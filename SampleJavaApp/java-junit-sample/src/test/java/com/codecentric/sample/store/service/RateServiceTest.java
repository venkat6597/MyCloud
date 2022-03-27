package com.codecentric.sample.store.service;

import com.codecentric.sample.store.model.Item;
import com.codecentric.sample.store.repository.ItemRepository;
import com.codecentric.sample.store.service.tools.StaticService;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.Parameterized;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.powermock.api.mockito.PowerMockito;
import org.powermock.core.classloader.annotations.PrepareForTest;
import org.powermock.modules.junit4.PowerMockRunner;
import org.powermock.modules.junit4.PowerMockRunnerDelegate;

import java.util.Arrays;
import java.util.Collection;

import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertThat;
import static org.mockito.Mockito.times;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;
import static org.powermock.api.mockito.PowerMockito.mockStatic;
import static org.powermock.api.mockito.PowerMockito.verifyStatic;

// See http://www.jayway.com/2014/11/29/using-another-junit-runner-with-powermock/
// for an example with the SpringJUnit4ClassRunner.class

@RunWith(PowerMockRunner.class)
@PowerMockRunnerDelegate(Parameterized.class)
@PrepareForTest({StaticService.class})
public class RateServiceTest {

    @Mock
    private ItemRepository itemRepositoryeMock;

    @InjectMocks
    private RateService rateService;

    @Parameterized.Parameters
    public static Collection<Object[]> data() {
        return Arrays.asList(new Object[][] {
                { new Item("it1", "item 1", "description 1", 20, true), 1, 20 },
                { new Item("it2", "item 2", "description 2", 30, true), 2, 60 },
                { new Item("it3", "item 3", "description 3", 40, true), 3, 120 },
        });
    }

    @Parameterized.Parameter(value = 0)
    public Item item;

    @Parameterized.Parameter(value = 1)
    public int multiplicator;

    @Parameterized.Parameter(value = 2)
    public int expected;

    @Before
    public void setup() {
        MockitoAnnotations.initMocks(this);
    }


    @Test
    public void rateCalculationTest() {

        //
        // Given
        //
        when(itemRepositoryeMock.findById(item.getId())).thenReturn(item);
        mockStatic(StaticService.class);
        PowerMockito.when(StaticService.getMultiplicator()).thenReturn(multiplicator);

        //
        // When
        //
        int result = rateService.calculateRate(item.getId(), multiplicator);

        //
        // Then
        //
        verify(itemRepositoryeMock, times(1)).findById(item.getId());
        verifyStatic(times(1));
        StaticService.getMultiplicator();

        assertThat(result, is(expected));
    }
}
