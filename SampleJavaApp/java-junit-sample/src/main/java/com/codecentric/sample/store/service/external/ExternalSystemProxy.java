package com.codecentric.sample.store.service.external;

import com.codecentric.sample.store.model.Customer;
import org.springframework.stereotype.Service;

import java.io.IOException;

@Service
public class ExternalSystemProxy {

    private static String dummy = null;

    public void update(Customer customer) {

        // Do something here that does not run outside test- or production environment
        dummy.equals("dummy");
    }


    public boolean connectionAvailable(String ipAddress) throws IOException {
        return true;
    }


}
