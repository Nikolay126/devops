package com.exadel.task3.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class Controller {

    private final String username;

    public Controller(@Value("${username}") String username) {
        this.username = username;
    }

    @GetMapping("/first")
    public String fistSimpleEndpoint() {
        return "Message from first simple endpoint";
    }

    @GetMapping("/second")
    public String secondSimpleEndpoint() {
        return "Message from second simple endpoint";
    }
}
