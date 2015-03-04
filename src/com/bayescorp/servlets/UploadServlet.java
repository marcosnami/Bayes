package com.bayescorp.servlets;

import java.io.File;
import java.io.IOException;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

@WebServlet("/uploadServlet")
public class UploadServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	private String uploadDir = "";
	public HttpSession session;
	
	public void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		doPost(request, response);
	}
	
	@Override
	public void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {

		session = request.getSession();
		
/*		Enumeration<String> paramNames = request.getParameterNames();
		while (paramNames.hasMoreElements()) {
			String paramName = (String)paramNames.nextElement();
		    String paramValue = request.getParameter(paramName);
		    System.out.println("Parameter Name: " + paramName + " and Parameter Value: " + paramValue);
	   	}
		String firstName = request.getParameter("firstName");
		String lastName = request.getParameter("lastName");
    	String username = request.getParameter("username");
    	System.out.println("Username: " + username);
    	System.out.println("First Name: " + firstName);
    	System.out.println("Last Name: " + lastName);
*/    	

		//System.out.println("You are trying to upload");
        // Process only if its multipart content
        if (ServletFileUpload.isMultipartContent(request)) {

        	FileItemFactory factory = new DiskFileItemFactory();
    		ServletFileUpload upload = new ServletFileUpload(factory);
    		try {
    			List<FileItem> fields = upload.parseRequest(request);
    			//System.out.println("Number of fields: " + fields.size());
                Iterator<FileItem> it = fields.iterator();
    			if (!it.hasNext()) {
    				System.out.println("No fields found");
    				return;
    			}
    			while (it.hasNext()) {
    				FileItem fileItem = it.next();
    				boolean isFormField = fileItem.isFormField();
    				if (isFormField) {
    					/*System.out.println("FIELD NAME: " + fileItem.getFieldName() + 
    							"\nSTRING: " + fileItem.getString());*/
    					String fieldName = fileItem.getFieldName();
    					if (fieldName.equals("username")) {
    						String username = fileItem.getString();
    						//System.out.println("Username: " + username);
    						uploadDir = getDirectory(username);
    						//System.out.println("Upload Directory: " + uploadDir);
    					}
    				} else {
    					/*System.out.println("FIELD NAME: " + fileItem.getFieldName() +
    							"\n NAME: " + fileItem.getName() +
    							"\n CONTENT TYPE: " + fileItem.getContentType() +
    							"\n SIZE (BYTES): " + fileItem.getSize() +
    							"\n TO STRING: " + fileItem.toString());*/
    					if (!fileItem.getName().equals("")) {
    						fileItem.write(new File(uploadDir + File.separator + fileItem.getName()));
    		    			//session.setAttribute("error", "File uploaded successfully");
    					} else {
    						session.setAttribute("error", "Please, choose a file to upload.");
    						break;
    					}
    				}
    			}
    			//request.setAttribute("message", "File Uploaded Successfully");
            } catch (Exception ex) {
            	session.setAttribute("error", "Failed to upload a file to the server");
               	System.out.println ("File Upload Failed due to " + ex.getMessage());
            }         
        } else {
        	session.setAttribute("error", "Sorry, this Servlet only handles multipart file upload request");
            //request.setAttribute("message", "Sorry this Servlet only handles file upload request");
        }
	        
        request.getRequestDispatcher("manageFiles.jsp").forward(request, response);
    }
	
	public static String getDirectory(String username) {
		String rootPath = System.getProperty("catalina.home");
        File file = new File(rootPath + File.separator + "tmpfiles" + File.separator + 
        		username + File.separator + "uploadDir");
        if(!file.exists()) { 
        	file.mkdirs();
            System.out.println("File Directory created to be used for storing files");
            System.out.println(rootPath + File.separator + "tmpfiles" + File.separator + 
            		username + File.separator + "uploadDir");
        }

		return file.getAbsolutePath();
	}

	public static String getDownDirectory(String username) {
		String rootPath = System.getProperty("catalina.home");
        File file = new File(rootPath + File.separator + "tmpfiles" + File.separator + 
        		username + File.separator + "downloadDir");
        if(!file.exists()) { 
        	file.mkdirs();
            System.out.println("File Directory created to be used for storing result files");
            System.out.println(rootPath + File.separator + "tmpfiles" + File.separator + 
            		username + File.separator + "downloadDir");
        }

		return file.getAbsolutePath();
	}


}