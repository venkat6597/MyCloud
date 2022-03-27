package com.codecentric.sample.store.service.external;

import org.junit.Before;
import org.junit.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import java.io.IOException;

import static org.mockito.Matchers.any;
import static org.mockito.Mockito.when;

public class HostServiceTest {

    @Mock
    private ExternalSystemProxy externalSystemProxy;

    @InjectMocks
    private HostService hostService;


    @Before
    public void setUp() throws Exception {
        MockitoAnnotations.initMocks(this);
    }

    @Test(expected = IOException.class)
    public void testConnectionNotAvailable() throws IOException {

        //
        // Given
        //
        when(externalSystemProxy.connectionAvailable(any(String.class))).thenThrow(new IOException());

        //
        // When
        //
        hostService.connect();

        //
        // Then
        //
        // Empty as we are expecting an exception to be thrown
    }
}
