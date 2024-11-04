package com.exadel.task3.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;

@Data
@Entity
@Table(name = "sample_user")
public class User {
    @Id
    private Long id;
    private String username;
}
