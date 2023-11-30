package com.bookrecommendonline.tool.recommend;

import java.util.List;

import org.apache.mahout.cf.taste.common.TasteException;
import org.apache.mahout.cf.taste.impl.neighborhood.NearestNUserNeighborhood;
import org.apache.mahout.cf.taste.impl.recommender.CachingRecommender;
import org.apache.mahout.cf.taste.impl.recommender.GenericItemBasedRecommender;
import org.apache.mahout.cf.taste.impl.recommender.GenericUserBasedRecommender;
import org.apache.mahout.cf.taste.impl.similarity.TanimotoCoefficientSimilarity;
import org.apache.mahout.cf.taste.impl.similarity.UncenteredCosineSimilarity;
import org.apache.mahout.cf.taste.model.DataModel;
import org.apache.mahout.cf.taste.neighborhood.UserNeighborhood;
import org.apache.mahout.cf.taste.recommender.RecommendedItem;
import org.apache.mahout.cf.taste.recommender.Recommender;
import org.apache.mahout.cf.taste.similarity.ItemSimilarity;
import org.apache.mahout.cf.taste.similarity.UserSimilarity;

import com.bookrecommendonline.entity.UserEntity;

/**
 * 协同过滤算法工具类
 * 基于用户的协同过滤推荐算法实现原理：
 * 1、根据用户图书评分信息构建用户-图书评分矩阵
 * 2、根据用户-图书评分矩阵计算用户之间的相似度
 * 3、根据用户之间的相似度得到目标用户的最近邻居KNN
 * 4、预测目标用户未评分图书的评分并进行推荐
 * 基于项目（图书）的协同过滤推荐算法实现原理：
 * 1、根据用户图书收藏信息构建用户-图书收藏矩阵
 * 2、根据用户-图书收藏矩阵计算图书之间的相似度
 * 3、预测目标用户未收藏的图书喜好值并进行推荐
 */
public class RecommendTool {

	//定义协同过滤推荐算法计算过程打印输出工具类
	private RecommendPrintTool cfPrintUtil = new RecommendPrintTool();

	/**
	 * 基于用户的协同过滤推荐算法，根据图书评分推荐
	 * @param cUser 当前登录用户
	 * @param model 用户-图书评分矩阵
	 */
	public String recommendByScoreBaseUser(UserEntity cUser,DataModel model){
		System.out.println("******基于用户的协同过滤推荐算法，根据图书评分推荐开始******");
		//定义推荐图书结果（字符串类型，以逗号分割图书id）
		String recommendItemids = "";
		//判断用户-图书评分矩阵是否为空
		if(model==null){
			System.out.println("***用户-图书评分矩阵为空***");
		}else{
			try {
				//定义相似度计算对象，余弦算法
				UserSimilarity userSimilarity =  new UncenteredCosineSimilarity(model);
				//输出目标用户与其他用户之间的相似度，
				cfPrintUtil.printSimilarityBaseUser(model, userSimilarity,
						cUser.getId());
				//定义最近邻对象
				UserNeighborhood neighborhood = new NearestNUserNeighborhood(
						RecommendCommonTool.knn, userSimilarity, model);
				long[] tempKnn = neighborhood.getUserNeighborhood(cUser.getId());
				//输出目标用户的最近邻居
				cfPrintUtil.printKNNBaseUser(tempKnn);
				//定义推荐引擎
				Recommender recommender = new CachingRecommender(
						new GenericUserBasedRecommender(model, neighborhood, userSimilarity));
				//推荐
				List<RecommendedItem> recommendations = recommender.recommend(
						cUser.getId(), RecommendCommonTool.recommendCount);
				//输出推荐结果
				cfPrintUtil.printRecommendResult(recommendations, cUser.getId());
				//返回推荐结果
	            for (RecommendedItem ritem : recommendations) {
	            	recommendItemids+=ritem.getItemID()+",";
	            }
	            if(!recommendItemids.equals("")){
	            	recommendItemids = recommendItemids.substring(0,recommendItemids.lastIndexOf(","));
	            }
			} catch (TasteException e) {
				e.printStackTrace();
			}
		}
		System.out.println("******基于用户的协同过滤推荐算法，根据图书评分推荐结束******");
		return recommendItemids;
	}

	/**
	 * 基于项目的协同过滤推荐算法，根据图书收藏推荐
	 * @param cUser 当前登录用户
	 * @param model 用户-图书收藏矩阵
	 */
	public String recommendByCollectBaseItem(UserEntity cUser,DataModel model){
		System.out.println("******基于项目的协同过滤推荐算法，根据图书收藏推荐开始******");
		//定义推荐图书结果（字符串类型，以逗号分割图书id）
		String recommendItemids = "";
		//判断用户-图书收藏矩阵是否为空
		if(model==null){
			System.out.println("***用户-图书收藏矩阵为空***");
		}else{
			try {
				//定义相似度计算对象，jaccard系数相似度算法
				ItemSimilarity itemSimilarity =  new TanimotoCoefficientSimilarity(model);
				//输出项目与项目之间的相似度，
				cfPrintUtil.printSimilarityBaseItem(model, itemSimilarity, 
						cUser.getId());
				//定义推荐引擎
				Recommender recommender = new CachingRecommender(
						new GenericItemBasedRecommender(model, itemSimilarity));
				//推荐
				List<RecommendedItem> recommendations = recommender.recommend(
						cUser.getId(), RecommendCommonTool.recommendCount);
				//输出推荐结果
				cfPrintUtil.printRecommendResult(recommendations, cUser.getId());
				//返回推荐结果
	            for (RecommendedItem ritem : recommendations) {
	            	recommendItemids+=ritem.getItemID()+",";
	            }
	            if(!recommendItemids.equals("")){
	            	recommendItemids = recommendItemids.substring(0,recommendItemids.lastIndexOf(","));
	            }
			} catch (TasteException e) {
				e.printStackTrace();
			}
		}
		System.out.println("******基于项目的协同过滤推荐算法，根据图书收藏推荐结束******");
		return recommendItemids;
	}

}