package com.codecentric.sample.store.model;

import java.util.UUID;

public class Item {


    private String id;

    private String name;

    private String description;

    private int priceInCents;

    private boolean isAvailable;

    public Item(String id, String name, String description, int priceInCents, boolean isAvailable) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.priceInCents = priceInCents;
        this.isAvailable = isAvailable;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getPriceInCents() {
        return priceInCents;
    }

    public void setPriceInCents(int priceInCents) {
        this.priceInCents = priceInCents;
    }

    public boolean isAvailable() {
        return isAvailable;
    }

    public void setAvailable(boolean available) {
        isAvailable = available;
    }
}
