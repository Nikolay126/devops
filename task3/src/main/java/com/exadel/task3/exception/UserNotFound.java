package com.exadel.task3.exception;

public class UserNotFound extends RuntimeException{

    public UserNotFound() {
        super("User not found");
    }
}
