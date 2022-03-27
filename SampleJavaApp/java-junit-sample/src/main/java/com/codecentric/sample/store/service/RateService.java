package com.codecentric.sample.store.service;

import com.codecentric.sample.store.model.Item;
import com.codecentric.sample.store.repository.ItemRepository;
import com.codecentric.sample.store.service.tools.StaticService;
import org.springframework.beans.factory.annotation.Autowired;

public class RateService {

    @Autowired
    private ItemRepository itemRepository;


    public int calculateRate(String itemId, int muliplicator) {

        Item item = itemRepository.findById(itemId);
        int rate = item.getPriceInCents() * StaticService.getMultiplicator();
        return rate;
    }

}
