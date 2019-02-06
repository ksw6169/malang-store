package com.malangstore.dao;

import com.malangstore.beans.Category;
import com.malangstore.beans.Product;
import com.malangstore.beans.Subcategory;

import java.util.HashMap;
import java.util.List;

public interface CategoryDao {
	public List<Subcategory> selectCategory(HashMap<String, Object> map);
}
