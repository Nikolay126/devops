package com.exadel.service;

import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

@RequiredArgsConstructor
@Service
public class UserService {

    @Value("${username}")
    private final String username;

    public String getDefaultUsername() {
        return username;
    }
}
