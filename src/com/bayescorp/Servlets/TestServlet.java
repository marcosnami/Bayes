package com.bayescorp.servlets;

import java.io.File;
import java.io.IOException;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

public class TestServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
		doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
		response.setContentType("text/html");

		System.out.println("Hello");

		boolean isMultipartContent = ServletFileUpload.isMultipartContent(request);
		if (!isMultipartContent) {
			System.out.println("You are not trying to upload");
			return;
		}
    	String username = request.getParameter("username");
    	String rootPath = System.getProperty("catalina.home");
        File file = new File(rootPath + File.separator + "tmpfiles" + File.separator + 
        		username + File.separator + "uploadDir");
        if(!file.exists()) { 
        	file.mkdirs();
            System.out.println("File Directory created to be used for storing files");
            System.out.println(rootPath + File.separator + "tmpfiles" + File.separator + 
            		username + File.separator + "uploadDir");
        }

		System.out.println("You are trying to upload");

		FileItemFactory factory = new DiskFileItemFactory();
		ServletFileUpload upload = new ServletFileUpload(factory);
		try {
			List<FileItem> fields = upload.parseRequest(request);
			System.out.println("Number of fields: " + fields.size());
			Iterator<FileItem> it = fields.iterator();
			if (!it.hasNext()) {
				System.out.println("No fields found");
				return;
			}
			System.out.println("table border=1");
			while (it.hasNext()) {
				System.out.println("tr");
				FileItem fileItem = it.next();
				boolean isFormField = fileItem.isFormField();
				if (isFormField) {
					System.out.println("<td>regular form field</td><td>FIELD NAME: " + fileItem.getFieldName() + 
							"<br/>STRING: " + fileItem.getString()
							);
					System.out.println("</td>");
				} else {
					System.out.println("<td>file form field</td><td>FIELD NAME: " + fileItem.getFieldName() +
							"<br/>STRING: " + fileItem.getString() +
							"<br/>NAME: " + fileItem.getName() +
							"<br/>CONTENT TYPE: " + fileItem.getContentType() +
							"<br/>SIZE (BYTES): " + fileItem.getSize() +
							"<br/>TO STRING: " + fileItem.toString()
							);
					System.out.println("</td>");
				}
				System.out.println("</tr>");
			}
			System.out.println("</table>");
		} catch (FileUploadException e) {
			e.printStackTrace();
		}
	}
}