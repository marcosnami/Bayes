package com.bayescorp.beans;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.Serializable;

import com.bayescorp.engine.datatypes.TextData;
import com.bayescorp.engine.io.ReadTextFile;
import com.bayescorp.engine.score.ScoreResult;
import com.bayescorp.engine.score.ScoringWrapper;
import com.bayescorp.servlets.UploadServlet;

public class scoreBean extends loginBean implements Serializable {

	private static final long serialVersionUID = 1L;
	private String fileName;
	private String profile;
	private String output;
	
	public String getFileName() {
		return fileName;
	}

	public String getProfile() {
		return profile;
	}

	public String getOutput() {
		return output;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public void setProfile(String profile) {
		this.profile = profile;
	}

	public void setOutput(String output) {
		this.output = output;
	}
	
    public boolean score() {
    	System.out.println("**** Scoring File Started At: " + new java.util.Date()+ " ****\n");
    	// Read file
        // Get file path
        String uploadFile = UploadServlet.getDirectory(getUsername()) + File.separator + getFileName();
        String downloadFile = UploadServlet.getDownDirectory(getUsername()) + File.separator + "Scored_" + getFileName();
        //System.out.println("File Path: " + uploadFile);
        //System.out.println("Result Path: " + downloadFile);
        String record = null;
    	try {
    		BufferedReader br = new BufferedReader(new FileReader(uploadFile));
    		BufferedWriter bw = new BufferedWriter(new FileWriter(downloadFile, true));
    		if (br != null) {
    			ReadTextFile rtf = new ReadTextFile();
    			ScoringWrapper scoringWrapper = new ScoringWrapper();
	           	while ((record = br.readLine()) != null) {
	           		TextData td = rtf.readText(record);
	           		//System.out.println(td.toString());
	           		ScoreResult sr = new ScoreResult();
	           		sr = scoringWrapper.scoringTriage1000(record);
	           		//System.out.println(sr.toString());
               		/*System.out.println(sr.getModelName() + ", " + 
                		sr.getClaimTotalOver500Score() + " - " + sr.getClaimTotalOver500Cell() + " - " + sr.getClaimTotalOver500Color() + ", " + 
                        sr.getClaimTotalUnder500Score() + " - " + sr.getClaimTotalUnder500Cell() + " - " + sr.getClaimTotalUnder500Color() + ", " + 
                        sr.getClaimTotalZeroScore() + " - " + sr.getClaimTotalZeroCell() + " - " + sr.getClaimTotalZeroColor() + " --- " +
                        sr.getScoreString());*/
               		bw.write(sr.getModelName() + ", " + 
                    		sr.getClaimTotalOver500Score() + " - " + sr.getClaimTotalOver500Cell() + " - " + sr.getClaimTotalOver500Color() + ", " + 
                            sr.getClaimTotalUnder500Score() + " - " + sr.getClaimTotalUnder500Cell() + " - " + sr.getClaimTotalUnder500Color() + ", " + 
                            sr.getClaimTotalZeroScore() + " - " + sr.getClaimTotalZeroCell() + " - " + sr.getClaimTotalZeroColor() + " --- " +
                            sr.getScoreString() + "\n");
	           	}
	           	br.close();
	           	bw.close();
    		}
    	} catch(Exception e) {
		   System.out.println("Error opening the file"+ e);
		   return false;
        }
    	
        System.out.println("**** Scoring File Finished At: " + new java.util.Date()+ " ****\n");
        return true;
    }

}
