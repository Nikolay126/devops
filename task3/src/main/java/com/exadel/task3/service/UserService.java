package com.exadel.task3.service;

import com.exadel.task3.entity.User;
import com.exadel.task3.exception.UserNotFound;
import com.exadel.task3.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@RequiredArgsConstructor
@Transactional(readOnly = true)
@Service
public class UserService {

    @Value("${username}")
    private final String username;

    private final UserRepository userRepository;

    public Iterable<User> getAll() {
        return userRepository.findAll();
    }

    public User getById(Long id) {
        return userRepository.findById(id).orElseThrow(UserNotFound::new);
    }

    public User getByUsername(String username) {
        return userRepository.findByUsername(username).orElseThrow(UserNotFound::new);
    }

    public String getDefaultUsername() {
        return username;
    }
}
