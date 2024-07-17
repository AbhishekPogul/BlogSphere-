package com.blog.model;

public class BlogPost {
    private int id;
    private String title;
    private String content;
    private byte[] image;
    private byte[] video;
    private int userId;

    // Constructors
    public BlogPost() {}

    public BlogPost(int id, String title, String content, byte[] image, byte[] video, int userId) {
        this.id = id;
        this.title = title;
        this.content = content;
        this.image = image;
        this.video = video;
        this.userId = userId;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public byte[] getImage() {
        return image;
    }

    public void setImage(byte[] image) {
        this.image = image;
    }

    public byte[] getVideo() {
        return video;
    }

    public void setVideo(byte[] video) {
        this.video = video;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }
}
