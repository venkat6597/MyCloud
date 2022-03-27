package com.codecentric.sample.store.service;

import com.codecentric.sample.store.model.Item;
import com.codecentric.sample.store.repository.ItemRepository;
import com.codecentric.sample.store.service.tools.StaticService;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.Mockito;
import org.mockito.MockitoAnnotations;
import org.powermock.core.classloader.annotations.PrepareForTest;
import org.powermock.modules.junit4.PowerMockRunner;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import static org.hamcrest.CoreMatchers.equalTo;
import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertThat;
import static org.mockito.Mockito.times;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;
import static org.powermock.api.mockito.PowerMockito.mockStatic;
import static org.powermock.api.mockito.PowerMockito.verifyStatic;

@RunWith(PowerMockRunner.class)
@PrepareForTest({StaticService.class})
public class ItemServiceTest {

    @Mock
    private ItemRepository itemRepository;

    @InjectMocks
    private ItemService itemService;


    @Before
    public void setUp() throws Exception {
        MockitoAnnotations.initMocks(this);
    }


    @Test
    public void getItemNameUpperCase() {

        //
        // Given
        //
        Item mockedItem = new Item("it1", "Item 1", "This is item 1", 2000, true);
        when(itemRepository.findById("it1")).thenReturn(mockedItem);

        //
        // When
        //
        String result = itemService.getItemNameUpperCase("it1");

        //
        // Then
        //
        verify(itemRepository, times(1)).findById("it1");
        assertThat(result, is("ITEM 1"));
    }

    @Test
    public void calculationOfAveragePriceForAllItems() {

        //
        // Given
        //
        List<Item> mockedItemList = new ArrayList<Item>();
        mockedItemList.add(new Item("it1", "Item 1", "This is item 1", 2000, true));

        when(itemRepository.readAllItems()).thenReturn(mockedItemList);
        mockStatic(StaticService.class);
        when(StaticService.getMultiplicator()).thenReturn(5);

        //
        // When
        //
        int averagePriceForAllItems = itemService.getAveragePriceForAllItems();

        //
        // Then
        //
        verify(itemRepository, times(1)).readAllItems();
        verifyStatic(times(1));
        StaticService.getMultiplicator();

        assertThat(averagePriceForAllItems, is(2000*5));
    }

    @Test
    public void readItemDescriptionWithoutIOException() throws IOException {

        //
        // Given
        //
        String fileName = "DummyName";

        mockStatic(StaticService.class);
        when(StaticService.readFile(fileName)).thenReturn("Dummy");

        //
        // When
        //
        String value = itemService.readItemDescription(fileName);

        //
        // Then
        //
        verifyStatic(times(1));
        StaticService.readFile(fileName);

        assertThat(value, equalTo("Dummy"));
    }

    @Test
    public void readItemDescriptionWithIOException() throws IOException {

        //
        // Given
        //
        String fileName = "DummyName";

        mockStatic(StaticService.class);
        when(StaticService.readFile(fileName)).thenThrow(IOException.class);

        //
        // When
        //
        String value = itemService.readItemDescription(fileName);

        //
        // Then
        //
        verifyStatic(times(1));
        StaticService.readFile(fileName);

        assertThat(value, is(""));
    }
}