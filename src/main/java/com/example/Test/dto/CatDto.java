package com.example.Test.dto;

import lombok.Builder;
import lombok.Data;
import java.time.LocalDateTime;

@Data
@Builder
public class CatDto {
    private Long id;
    private String name;
    private String photoUrl;
    private String content;
    private String gender;
    private String age;
    private String volunteer;
    private String phone;
}

