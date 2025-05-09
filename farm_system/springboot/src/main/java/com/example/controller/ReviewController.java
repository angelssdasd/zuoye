package com.example.controller;

import com.example.entity.review;
import com.example.service.ReviewService;
import com.github.pagehelper.PageInfo;
import jakarta.annotation.Resource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController // 注意这里首字母大写
@RequestMapping("/review") // 注意这里首字母大写
public class ReviewController {

    @Resource
    private ReviewService reviewService;

    @GetMapping("/selectPage")
    public PageInfo<review> list(
            @RequestParam int pageNum, // 注意这里首字母大写
            @RequestParam int pageSize, // 注意这里首字母大写
            @RequestParam(required = false) String reviewerId) {
        int k=3;
        return reviewService.list(pageNum, pageSize, reviewerId);
    }

    @GetMapping("/{id}")
    public review getById(@PathVariable Integer id) {
        return reviewService.getById(id);
    }

    @PostMapping("/add")
    public boolean add(@RequestBody review review) { // 注意这里首字母大写
        return reviewService.add(review);
    }

    @PutMapping("/update")
    public boolean update(@RequestBody review review) { // 注意这里首字母大写
        return reviewService.update(review);
    }

    @DeleteMapping("/delete/{id}")
    public boolean delete(@PathVariable Integer id) {
        return reviewService.delete(id);
    }
}