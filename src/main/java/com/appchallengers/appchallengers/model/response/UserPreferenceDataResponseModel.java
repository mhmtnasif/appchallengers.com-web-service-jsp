package com.appchallengers.appchallengers.model.response;

public class UserPreferenceDataResponseModel {

    private String  token;
    private String fullName;
    private String imageUrl;
    private String email;
    private Integer active;
    private String country;

    public UserPreferenceDataResponseModel(String token, String fullName, String imageUrl, String email, Integer active, String country) {
        this.token = token;
        this.fullName = fullName;
        this.imageUrl = imageUrl;
        this.email = email;
        this.active = active;
        this.country = country;
    }

    public UserPreferenceDataResponseModel() {
    }
}
