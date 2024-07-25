package com.example.Test.service.impl;

import com.example.Test.dto.CatDto;
import com.example.Test.models.Cat;
import com.example.Test.repository.CatRepository;
import com.example.Test.service.CatService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class CatServiceImpl implements CatService {
    private CatRepository catRepository;

    @Autowired
    public CatServiceImpl(CatRepository catRepository) {
        this.catRepository = catRepository;
    }

    @Override
    public List<CatDto> findAllCats() {
        List<Cat> cats = catRepository.findAll();
        return cats.stream().map((cat) -> mapToClubDto(cat)).collect(Collectors.toList());
    }

    @Override
    public List<CatDto> searchCats(String query) {
        List<Cat> cats = catRepository.searchCats(query);
        return cats.stream().map(cat -> mapToClubDto(cat)).collect(Collectors.toList());
    }

    @Override
    public CatDto findCatById(long catId) {
        Cat cat = catRepository.findById(catId).get();
        return mapToClubDto(cat);
    }

    private CatDto mapToClubDto(Cat cat) {
        CatDto catDto = CatDto.builder()
                .id(cat.getId())
                .name(cat.getName())
                .photoUrl(cat.getPhotoUrl())
                .content(cat.getContent())
                .gender(cat.getGender())
                .age(cat.getAge())
                .volunteer(cat.getVolunteer())
                .phone(cat.getPhone())
                .build();
        return catDto;
    }
}
