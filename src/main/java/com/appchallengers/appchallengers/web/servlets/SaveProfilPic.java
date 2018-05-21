package com.appchallengers.appchallengers.web.servlets;

import com.appchallengers.appchallengers.dao.dao.UserDao;
import com.appchallengers.appchallengers.dao.daoimpl.UserDaoImpl;
import com.appchallengers.appchallengers.endpoint.error_handling.CommonExceptionHandler;
import com.appchallengers.appchallengers.model.entity.Users;
import com.appchallengers.appchallengers.util.Util;
import com.appchallengers.appchallengers.web.bussiness.BussinessLogin;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;

import java.security.NoSuchAlgorithmException;
import java.sql.Timestamp;
import java.util.Calendar;
import java.util.Locale;
import java.util.logging.Level;

@WebServlet(name = "SaveProfilPic", urlPatterns = {"/SaveProfilPic"})
@MultipartConfig
public class SaveProfilPic extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        HttpSession session1 = request.getSession(false);
        String userName = null;
        javax.servlet.http.Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (javax.servlet.http.Cookie cookie : cookies) {
                if (cookie.getName().equals("user"))
                    userName = cookie.getValue();


            }
        }else{
            userName=(String)session1.getAttribute("username");
        }
        String url = "http://appchallengers.com/images/";
        UserDao userDao= new UserDaoImpl();
        Users users=userDao.findByEmail(userName);

        final Part filePart = request.getPart("my_file");
        final String fileName = getFileName(filePart);
        java.sql.Timestamp currentTimestamp = new java.sql.Timestamp(Calendar.getInstance(Locale.US).getTime().getTime());

        String uploadedFileLocation = null;
        String fileNewName=null;
        try {
            fileNewName=Util.hashMD5(currentTimestamp.toString() + userName) + fileName;
            uploadedFileLocation = "C:\\Users\\Administrator\\Desktop\\appchallengers\\med\\profileimages\\"+fileNewName;
        } catch (NoSuchAlgorithmException e) {

        }

        OutputStream out = null;
        InputStream filecontent = null;
        final PrintWriter writer = response.getWriter();
        try{
            out = new FileOutputStream(new File( uploadedFileLocation));
            filecontent = filePart.getInputStream();
            int read = 0;
            final byte[] bytes = new byte[1024];
            while ((read = filecontent.read(bytes)) != -1) {
                //  System.out.println("calıstı");
                out.write(bytes, 0, read);
            }




           // System.out.println("ooooooooooooooooo"+userName);
            userDao.updateProfileWithPhoto(users.getId(),url+fileNewName,users.getFullName(),users.getCountry());
            response.sendRedirect("myprofile.jsp");
        }catch(Exception e){
            System.out.println(e.getMessage());
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    private String getFileName(final Part part) {
        final String partHeader = part.getHeader("content-disposition");
        // LOGGER.log(Level.INFO, "Part Header = {0}", partHeader);
        for (String content : part.getHeader("content-disposition").split(";")) {
            if (content.trim().startsWith("filename")) {
                return content.substring(
                        content.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return null;
    }
}
