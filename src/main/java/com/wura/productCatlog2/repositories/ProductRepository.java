package com.wura.productCatlog2.repositories;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.wura.productCatlog2.models.Product;

@Repository
public interface ProductRepository extends CrudRepository<Product, Long> {
	
}
