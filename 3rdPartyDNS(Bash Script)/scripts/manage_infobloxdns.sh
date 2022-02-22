#/bin/bash

set -x
set -eou pipefail

# function to display the usage detials of this script
usage() {
	echo "
DESCRIPTION
    Manages infoblox DNS entries 

SYNOPSIS
    $0 --action 'get|Add|update|delete' --recordType 'A-Record|CName-Record' --environment NonProduction|Production --zone "" --ip "" --record "" --aRecord "" --cnameRecord "" --user infobloxadmin --password infbloxpassword --server infobloxip

ARGUMENTS
    --action <Add|update|delete>
        Action that is to be performed in infoblox for DNS entries

    --recordType <A-Record|CName-Record>
        Type of record that should be created 
        
    --environment
        Name of the envirnment for which the infoblox entry should be created
	
	--zone
		infoblox dns zone in which the record should be created
	
	--ip
		IP address incase if A record shoud be created

	--record
		entry name with which the record should be created infoblox

	--aRecord
		a record against which CName-Record should be created

	--user <infoblox user name>
		User name of the infoblox

	--password <infoblox password>
		Password of infoblox
	  
	--server <infobloxip>
	         IP if infoblox
		

" >&2
	exit 1
}

main() {

    # validation and assigning values to relevant variables
	if [[ "$#" -eq 0 ]]; then usage; exit 1 ; fi
	while [[ "$#" -gt 0 ]]; do
		case "${1:-}" in
		-h | --help)
			usage
			;;

		--action)
			Action="$2"
			;;
		--recordType)
			RecordType="$2"
            check_value recordType ${RecordType}
			;;
		--environment)
			Environment="$2"
			;;
		--zone)
			Zone="$2"
			;;
		--ip)
			IP="$2"
			;;
		--record)
			RecordName="$2"
			;;
		--aRecord)
			ARecord="$2"
			;;
            --cnameRecord)
			CNAME_Record="$2"
			;;   
               --exrecord)
			Exist_Record="$2"
			;;       
		   --user)
			username="$2"
			;;
		--password)
			password="$2"
			;;
                --server)
		        infobloxip="$2"
			;;
		esac
		shift
	done
    # call function to check whether required details are available to manage infoblox details
    check_value user $username
    check_value password $password
    check_details

    case "${Action}" in
    get)
        echo $(fetch_dns_details $RecordName.$Zone)
        ;;
    Add)
        check_existing_record
        add_dns
        ;;
    Update)
        check_existing_record
        update_dns
        ;;
    delete)
        delete_dns
        ;;
    *)
        echo "${Action} is not a suitable action" && exit 1
        ;;
    esac

}


fetch_dns_details2(){
if [[ "$Action" == "Update" ]]; then
    curl --silent -X GET \
        -H "Content-Type: application/json" \
        -k1 -u $username:$password \
        https://${infobloxip}/wapi/v2.9/record:a -d '{"ipv4addr":"'${1}'"}'
 
fi          
}


# function to check and return the details of existing infoblox entries
fetch_dns_details(){
if [[ "$RecordType" == "A-Record" || "$Action" == "Update"  ]]; then
    curl --silent -X GET \
        -H "Content-Type: application/json" \
        -k1 -u $username:$password \
        https://${infobloxip}/wapi/v2.9/record:a -d '{"name":"'${1}'"}'      
elif [[ "$RecordType" == "CName-Record" ]]; then 
    curl --silent -X GET \
        -H "Content-Type: application/json" \
        -k1 -u $username:$password \
        https://${infobloxip}/wapi/v2.10/record:cname  -d '{"name":"'${1}'","canonical":"'$CNAME_Record'"}'  
fi          
}


add_dns(){
    #infoblox_ip=${infobloxip}
    if [[ "$RecordType" == "A-Record" ]]; then 
        curl --silent -X POST \
            -H "Content-Type: application/json" \
            -k1 -u $username:$password \
            https://${infobloxip}/wapi/v2.9/record:a \
	    -d '{"name": "'$RecordName.$Zone'", "ipv4addr":"'$IP'","view": "MNSINTERNAL","extattrs": {"Tenant ID":{"value": "bd5c6713-7399-4b31-be79-78f2d078e543"} , "CMP Type":{"value":"azure"}, "Cloud API Owned": {"value":"True"}}}'
    elif [[ "$RecordType" == "CName-Record" ]]; then 
        curl -k -u $username:$password \
            -H 'content-type: application/json' \
            -k1 -u $username:$password \
            -X POST "https://${infobloxip}/wapi/v2.10/record:cname?_return_fields%2B=name,canonical&_return_as_object=1"  \
            -d '{"name":"'$ARecord'","canonical":"'$CNAME_Record'","view":"MNSINTERNAL","extattrs": {"Tenant ID":{"value": "bd5c6713-7399-4b31-be79-78f2d078e543"} , "CMP Type":{"value":"azure"}, "Cloud API Owned": {"value":"True"}}}' 
    fi
}

update_dns(){
    recordObject=$(fetch_dns_details $Exist_Record | jq -r '.[]._ref')
    if [ ! -z "$recordObject" ]; then
         curl --silent -X PUT \
            -H "Content-Type: application/json" \
            -k1 -u $username:$password \
            https://${infobloxip}/wapi/v2.9/$recordObject \
            -d '{"ipv4addr": "'$IP'"}'
    else
        echo "No record exist, please run with add" && exit 1
    fi
}

delete_dns(){
    infoblox_ip="infoblox_${infobloxip}_ip"
    recordObject=$(fetch_dns_details $RecordName.$Zone | jq -r '.[]._ref')
    if [ ! -z "$recordObject" ]; then
        curl --silent -X DELETE \
                -H "Content-Type: application/json" \
                -k1 -u $username:$password \
                https://${!infoblox_ip}/wapi/v2.9/$recordObject
        
        if [ $(fetch_dns_details $RecordName.$Zone | jq -r '.[].name') ]; then
            echo "Record Not deleted" &&  exit 1
        else
            echo "record deleted successfully"
        fi
    else
        echo "no record exits" 
    fi

}

#function to check existing records
check_existing_record(){
    if [[ "$RecordType" == "A-Record" ]]; then
     if [ $(fetch_dns_details $RecordName.$Zone | jq -r '.[].name') ]; then
        echo "Record already exist" && exit 1
     fi
    elif [[ "$RecordType" == "CName-Record" ]]; then   
     if [ $(fetch_dns_details $ARecord | jq -r '.[].name') ]; then
      echo "Record already exist" && exit 1
     fi
    elif [[ "$Action" == "Update" ]]; then   
     if [ $(fetch_dns_details2 $IP | jq -r '.[].ipv4addr') ]; then
      echo "Record already exist" && exit 1
     fi
    fi 
}


# function to check whether necessary details are available to manage infoblox entries
check_details(){

    if [[ ("$Action" == "Add") ]]; then 
        case "${RecordType}" in 
        A-Record)
            if [[ -z $Environment || -z $Zone || -z $RecordName || -z $IP ]]; then 
                echo "one or more values required for A-Record is null" && exit 1
            fi
            export type=a
            ;;
        CName-Record)
            if [[ -z $Environment || -z $Zone || -z $ARecord || -z $CNAME_Record  ]]; then 
                echo "one or more values required for CName-Record is null" && exit 1
            fi
            export type=cname
            ;;
        *)
            echo "unknown record type. It should be eiter A-Record or CName-Record" && exit 1
            ;;
        esac
    elif [[ ("$Action" == "get") || ("$Action" == "delete")  ]]; then 
        case "${RecordType}" in 
        A-Record)
            if [[ -z $Environment || -z $Zone || -z $RecordName ]]; then 
                echo "one or more values required for A-Record is null" && exit 1
            fi
            export type=a
            ;;
        CName-Record)
            if [[ -z $Environment || -z $Zone || -z $RecordName ]]; then 
                echo "one or more values required for CName-Record is null" && exit 1
            fi
            export type=cname
            ;;
        *)
            echo "unknown record type. it should be eiter A-Record or CName-Record. check -h" && exit 1
            ;;
        esac
    fi 
}



check_value(){
	if [[ ("$2" == "NA") || ( -z "$2") ]]; then 
		echo "Code1: $1 value is not set"
		exit 1
	fi
}

main "$@"
