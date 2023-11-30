package com.bookrecommendonline.tool.recommend;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.mahout.cf.taste.impl.common.FastByIDMap;
import org.apache.mahout.cf.taste.impl.common.FastIDSet;
import org.apache.mahout.cf.taste.impl.model.GenericBooleanPrefDataModel;
import org.apache.mahout.cf.taste.impl.model.GenericDataModel;
import org.apache.mahout.cf.taste.impl.model.GenericPreference;
import org.apache.mahout.cf.taste.impl.model.GenericUserPreferenceArray;
import org.apache.mahout.cf.taste.model.DataModel;
import org.apache.mahout.cf.taste.model.Preference;
import org.apache.mahout.cf.taste.model.PreferenceArray;

import com.bookrecommendonline.entity.BookcollectEntity;
import com.bookrecommendonline.entity.BookscoreEntity;
import com.bookrecommendonline.entity.UserEntity;

/**
 * 协同过滤推荐算法构建用户-图书操作行为（评分、收藏等）矩阵工具类
 */
public class RecommendDataModelTool {

	/**
	 * 构建用户-图书评分矩阵
	 * @param bookscoreList 图书评分集合
	 * @param cUser 当前用户/目标用户
	 * @return
	 */
	public DataModel getDadaModelByScore(List<BookscoreEntity> bookscoreList,
			UserEntity cUser){
		System.out.println("******构建用户-图书评分矩阵开始******");
		//定义空矩阵变量
		DataModel model = null;
		Boolean flag = false;//标记当前登录的用户是否有图书评分记录
		//如果数据库中有图书评分记录
		if(bookscoreList!=null && bookscoreList.size()>0){
			//定义map集合保存用户id和图书评分集合
			Map<Integer,List<Preference>> map = new HashMap<Integer,List<Preference>>();
			//遍历图书评分集合
			for(BookscoreEntity bookscore:bookscoreList){
				int userid = bookscore.getUserid();//用户id
				if(userid==cUser.getId()){//判断是否是目标用户
					flag = true;
				}
				int bookid = bookscore.getBookid();//图书id
				float preference = bookscore.getScore();//评分
				//某个用户的评分集合
				List<Preference> preferenceList = null;
				//判断map集合中是否已存在当前遍历用户id
				if(map.containsKey(userid)){
					preferenceList = map.get(userid);
				}else{
					preferenceList = new ArrayList<Preference>();
				}
				//list评分集合添加评分数据
				preferenceList.add(new GenericPreference(userid, bookid, preference));
				//map评分集合添加评分数据
				map.put(userid, preferenceList);
			}
			if(!flag){
				System.out.println("***当前登录用户没有图书评分记录！***");
			}else{
				//定义用户-图书评分map集合（类型转换）
				FastByIDMap<PreferenceArray> preferences = new FastByIDMap<PreferenceArray>();
				Set<Integer> set = map.keySet();
				for(Integer i:set){
					List<Preference> preferenceList = map.get(i);
					preferences.put(i,new GenericUserPreferenceArray(preferenceList));
				}
				//实例化用户-图书评分矩阵
			    model = new GenericDataModel(preferences);
			}
		}else{
			System.out.println("******数据库中没有图书评分记录！******");
		}
		System.out.println("******构建用户-图书评分矩阵结束******");
		return model;
	}

	/**
	 * 构建用户-图书收藏矩阵
	 * @param bookcollectList 图书收藏集合
	 * @param cUser 当前用户/目标用户
	 * @return
	 */
	public DataModel getDadaModelByCollect(List<BookcollectEntity> bookcollectList,
			UserEntity cUser){
		System.out.println("******构建用户-图书收藏矩阵开始******");
		//定义空矩阵变量
		DataModel model = null;
		Boolean flag = false;//标记当前登录的用户是否有图书收藏记录
		//如果数据库中有图书收藏记录
		if(bookcollectList!=null && bookcollectList.size()>0){
			//定义用户-图书收藏map集合
			FastByIDMap<FastIDSet> map = new FastByIDMap<FastIDSet>();
			//遍历图书收藏集合
			for(BookcollectEntity bookcollect:bookcollectList){
				int userid = bookcollect.getUserid();//用户id
				if(userid==cUser.getId()){//判断是否是目标用户
					flag = true;
				}
				int bookid = bookcollect.getBookid();//图书id
				//图书收藏set集合
				FastIDSet fastIDSet = null;
				//判断map集合中是否有用户
				if(map.containsKey(userid)){
					fastIDSet = map.get(userid);
				}else{
					fastIDSet = new FastIDSet();
				}
				//集合中添加图书id
				fastIDSet.add(bookid);
				//map集合中保存用户-图书收藏数据
				map.put(userid,fastIDSet);
			}
			if(!flag){
				System.out.println("***当前登录用户没有图书收藏记录！***");
			}else{
				//实例化用户-图书收藏矩阵
			    model = new GenericBooleanPrefDataModel(map);
			}
		}else{
			System.out.println("******数据库中没有图书收藏记录！******");
		}
		System.out.println("******构建用户-图书收藏矩阵结束******");
		return model;
	}
	
}
