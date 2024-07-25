package com.example.Test.service;

import com.example.Test.dto.CatDto;

import java.util.List;

public interface CatService {
    List<CatDto> findAllCats();
    List<CatDto> searchCats(String query);
    CatDto findCatById(long clubId);
}

