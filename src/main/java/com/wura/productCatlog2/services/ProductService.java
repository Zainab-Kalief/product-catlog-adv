package com.wura.productCatlog2.services;

import java.util.List;

import org.springframework.stereotype.Service;

import com.wura.productCatlog2.models.Product;
import com.wura.productCatlog2.repositories.ProductRepository;

@Service
public class ProductService {
	private ProductRepository productRepo;
	public ProductService(ProductRepository productRepo) {
		this.productRepo = productRepo;
	}
	
	public List<Product> all() {
		return (List<Product>) productRepo.findAll();
	}
	public void add(Product product) {
		productRepo.save(product);
	}
	public Boolean delete(Long id) {
		if(productRepo.findOne(id) != null) {
			productRepo.delete(id);
			return true;
		}
		return false;
	}
	public Product find(Long id) {
		return productRepo.findOne(id);
	}
	public Product update(Product product) {
		return productRepo.save(product);
	}
}
