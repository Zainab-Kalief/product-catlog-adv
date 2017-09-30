package com.wura.productCatlog2.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wura.productCatlog2.models.Product;
import com.wura.productCatlog2.services.ProductService;

@Controller
public class ProductController {
	private final ProductService service;
	public ProductController(ProductService service) {
		this.service = service;
	}
	
	@RequestMapping("/") 
	public String home() {
		return "home";
	}
	
	@RequestMapping(path="/new", method=RequestMethod.POST)
	public @ResponseBody Product newProduct(@RequestBody Product product) {
		service.add(product);
		return product;
	}
	@RequestMapping("/delete")
	public @ResponseBody Boolean deleteProduct(@RequestParam(value="id") Long id) {
		if(service.delete(id)) {
			return true;
		}
		return false;
	}
	@RequestMapping("/find")
	public @ResponseBody Product findProduct(@RequestParam(value="id") Long id) {
		return service.find(id);
	}
	@RequestMapping(path="/update", method=RequestMethod.POST)
	public @ResponseBody Product updateProduct(@RequestBody Product product) {
		return service.update(product);
	}
}
