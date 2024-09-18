/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author admin
 */
public class document {
    private int documentid;
    private String videourl;
    private String slideurl;
    private lessons lessonid;

    public document() {
    }

    public document(int documentid, String videourl, String slideurl, lessons lessonid) {
        this.documentid = documentid;
        this.videourl = videourl;
        this.slideurl = slideurl;
        this.lessonid = lessonid;
    }

    public int getDocumentid() {
        return documentid;
    }

    public void setDocumentid(int documentid) {
        this.documentid = documentid;
    }

    public String getVideourl() {
        return videourl;
    }

    public void setVideourl(String videourl) {
        this.videourl = videourl;
    }

    public String getSlideurl() {
        return slideurl;
    }

    public void setSlideurl(String slideurl) {
        this.slideurl = slideurl;
    }

    public lessons getLessonid() {
        return lessonid;
    }

    public void setLessonid(lessons lessonid) {
        this.lessonid = lessonid;
    }

    
}
