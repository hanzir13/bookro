package com.bookrecommendonline.tool.recommend;

import java.util.List;

import org.apache.mahout.cf.taste.common.TasteException;
import org.apache.mahout.cf.taste.impl.common.LongPrimitiveIterator;
import org.apache.mahout.cf.taste.model.DataModel;
import org.apache.mahout.cf.taste.recommender.RecommendedItem;
import org.apache.mahout.cf.taste.similarity.ItemSimilarity;
import org.apache.mahout.cf.taste.similarity.UserSimilarity;

/**
 * 协同过滤推荐算法计算过程打印输出工具类
 */
public class RecommendPrintTool {

	/**
	 * 打印输出推荐结果
	 * @param recommendations 推荐结果
	 * @param cUserid 当前用户id
	 */
	public void printRecommendResult(List<RecommendedItem> recommendations,int cUserid){
		System.out.println("***输出推荐结果开始***");
		System.out.printf("目标用户:%s", cUserid);
		System.out.println("推荐结果：");
        for(RecommendedItem ritem : recommendations) {
            System.out.printf("(%s,%f)", ritem.getItemID(), ritem.getValue());
            System.out.println("");
        }
		System.out.println("***输出推荐结果结束***");
	}

	/**
	 * 输出用户之间的相似度,基于用户的协同过滤算法
	 * @param dataModel
	 * @param userSimilarity
	 * @param cUserid 目标用户id
	 */
	public void printSimilarityBaseUser(DataModel dataModel,
			UserSimilarity userSimilarity,int cUserid){
		System.out.println("***输出用户之间的相似度开始***");
		try {
			LongPrimitiveIterator iterator = dataModel.getUserIDs();
			while(iterator.hasNext()){
				long id = iterator.next();
				double sim = userSimilarity.userSimilarity(cUserid, id);
				System.out.println("目标用户:"+cUserid+"  与用户："+id+"  相似度="+sim);
			}
		} catch (TasteException e) {
			System.out.println("输出基于用户的用户之间相似度报错！");
			e.printStackTrace();
		}
		System.out.println("***输出用户之间的相似度结束***");
	}

	/**
	 * 输出最近邻之间的相似度,基于用户的协同过滤算法
	 * @param knn
	 */
	public void printKNNBaseUser(long[] knn){
		System.out.println("***输出最近邻开始***");
		System.out.print("最近邻：");
		for(long l:knn){
			System.out.print(l+"    ");
		}
		System.out.println("\n***输出最近邻结束***");
	}

	/**
	 * 输出项目之间的相似度,基于项目的协同过滤算法
	 * @param dataModel
	 * @param itemSimilarity
	 * @param cUserid 目标用户id
	 */
	public void printSimilarityBaseItem(DataModel dataModel,
			ItemSimilarity itemSimilarity,int cUserid){
		System.out.println("***输出项目之间的相似度开始***");
		try {
			//获取矩阵中的所有项目
			LongPrimitiveIterator iterator = dataModel.getItemIDs();
			//获取第一个项目
			long idTemp = iterator.next();
			//遍历其他项目
			while(iterator.hasNext()){
				long id = iterator.next();
				//计算相似度
				double sim = itemSimilarity.itemSimilarity(idTemp, id);
				System.out.println("项目:"+idTemp+"  与项目："+id+"  相似度="+sim);
			}
		} catch (TasteException e) {
			System.out.println("输出基于项目的项目之间相似度报错！");
			e.printStackTrace();
		}
		System.out.println("***输出项目之间的相似度结束***");
	}
	
}
