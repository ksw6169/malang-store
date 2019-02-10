package com.malangstore.dao;

import com.malangstore.beans.Subcategory;

import java.util.HashMap;
import java.util.List;

public interface CategoryDao {
	public List<Subcategory> getSubCategories(HashMap<String, Object> map);

	public String getCategoryName(int subCategoryNo);
}
