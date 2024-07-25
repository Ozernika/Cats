package com.example.Test.controllers;

import com.example.Test.dto.CatDto;
import com.example.Test.service.CatService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import java.util.List;

@Controller
public class CatController {
    private CatService catService;

    @Autowired
    public CatController(CatService catService) {
        this.catService = catService;
    }

    @GetMapping("/cats")
    public String listCats(Model model) {
        List<CatDto> cats = catService.findAllCats();
        model.addAttribute("cats", cats);
        return "cats-list";
    }

    @GetMapping("/cats/search")
    public String searchCat(@RequestParam(value = "query") String query, Model model) {
        List<CatDto> cats = catService.searchCats(query);
        model.addAttribute("cats", cats);
        return "cats-list";
    }

    @GetMapping("/cats/{catId}")
    public String catDetail(@PathVariable("catId") long catId, Model model) {
        CatDto catDto = catService.findCatById(catId);
        model.addAttribute("cat", catDto);
        return "cats-detail";
    }
}

