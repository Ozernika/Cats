package com.example.Test.service;

import com.example.Test.dto.RegistrationDto;
import com.example.Test.models.UserEntity;

public interface UserService {
    void saveUser(RegistrationDto registrationDto);

    UserEntity findByEmail(String email);

    UserEntity findByUsername(String username);
}
