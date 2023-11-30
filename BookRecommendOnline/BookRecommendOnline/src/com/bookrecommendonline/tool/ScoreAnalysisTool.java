package com.bookrecommendonline.tool;

import java.text.DecimalFormat;
import java.util.List;

/**
 * 评分分析实体类
 */
public class ScoreAnalysisTool {

	private float avgScore;  //平均评分
	private int scoreCount;  //评分总数
	private int sumScore;  //总评分
	//具体评分分析集合
	List<CurScoreAnalysisTool> curScoreAnalysisToolList;
	
	public float getAvgScore() {
		if(sumScore==0 || scoreCount==0){
			avgScore = 0;
		}else{
			avgScore = (float)sumScore/(float)scoreCount;
			DecimalFormat fnum = new DecimalFormat("##0.0");  
			avgScore = Float.parseFloat(fnum.format(avgScore));
		}
		return avgScore;
	}
	
	public void setAvgScore(float avgScore) {
		this.avgScore = avgScore;
	}
	
	public int getScoreCount() {
		return scoreCount;
	}
	
	public void setScoreCount(int scoreCount) {
		this.scoreCount = scoreCount;
	}
	
	public int getSumScore() {
		return sumScore;
	}
	
	public void setSumScore(int sumScore) {
		this.sumScore = sumScore;
	}
	public List<CurScoreAnalysisTool> getCurScoreAnalysisToolList() {
		return curScoreAnalysisToolList;
	}
	
	public void setCurScoreAnalysisToolList(List<CurScoreAnalysisTool> curScoreAnalysisToolList) {
		this.curScoreAnalysisToolList = curScoreAnalysisToolList;
	}
	
}