package com.appchallengers.appchallengers.util;


import com.google.gson.Gson;

public class GlobalGson {

    private Gson gson = new Gson();

    private static final GlobalGson globalGson = new GlobalGson();

    public static GlobalGson getGlobalGson() {
        return globalGson;
    }

    private GlobalGson() {
    }

    public Gson getGson() {
        if (gson == null) {
            gson = new Gson();
        }
        return gson;
    }


}