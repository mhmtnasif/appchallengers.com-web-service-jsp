package com.appchallengers.appchallengers.util;

import com.appchallengers.appchallengers.endpoint.error_handling.CommonExceptionHandler;
import io.jsonwebtoken.*;

import java.io.*;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class Util {

    public static String hashMD5(String password) throws NoSuchAlgorithmException {
        MessageDigest md = MessageDigest.getInstance("MD5");
        md.update(password.getBytes());
        byte byteData[] = md.digest();
        StringBuffer sb = new StringBuffer();
        for (int i = 0; i < byteData.length; i++) {
            sb.append(Integer.toString((byteData[i] & 0xff) + 0x100, 16).substring(1));
        }
        return sb.toString();
    }

    public static boolean writeToFile(InputStream uploadedInputStream, String uploadedFileLocation) {
        try {
            OutputStream out = new FileOutputStream(new File(
                    uploadedFileLocation));
            int read = 0;
            byte[] bytes = new byte[1024];

            out = new FileOutputStream(new File(uploadedFileLocation));
            while ((read = uploadedInputStream.read(bytes)) != -1) {
                out.write(bytes, 0, read);
            }
            out.flush();
            out.close();
            return true;
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }

    }

    public static String createToken(String email, String name, long id) throws UnsupportedEncodingException {
        String jwt = Jwts.builder()
                .setSubject(email)
                .claim("name", name)
                .claim("id", id)
                .signWith(
                        SignatureAlgorithm.HS256,
                        "secret".getBytes("UTF-8")
                )
                .compact();
        return jwt;
    }

    public static String getEmailFromToken(String token) throws UnsupportedEncodingException {
        Jws<Claims> claims = Jwts.parser()
                .setSigningKey("secret".getBytes("UTF-8"))
                .parseClaimsJws(token);
        return claims.getBody().getSubject();
    }

    public static Integer getIdFromToken(String token) throws UnsupportedEncodingException {
        Jws<Claims> claims = Jwts.parser()
                .setSigningKey("secret".getBytes("UTF-8"))
                .parseClaimsJws(token);
        return (Integer) claims.getBody().get("id");
    }

    public static long getId(String token) throws CommonExceptionHandler {
        try {
            return Util.getIdFromToken(token);
        } catch (UnsupportedEncodingException e) {
            throw new CommonExceptionHandler("289");
        } catch (MalformedJwtException exception) {
            throw new CommonExceptionHandler("289");
        } catch (SignatureException exception) {
            throw new CommonExceptionHandler("289");
        }
    }
}
