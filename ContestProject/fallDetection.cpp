//
//  fallDetection.cpp
//  
//
//  Created by sopa potikanya on 15/8/2562 BE.
//

#include "fallDetection.hpp"

#include <iostream>
#include <raspicam/raspicam_cv.h>
#include "opencv2/opencv.hpp"
#include "opencv2/imgproc/imgproc.hpp"
#include "opencv2/highgui/highgui.hpp"
#include <stdlib.h>
#include <stdio.h>
#include <wiringPi.h>

#define motor1A 4
#define motor1B 5
#define motor1E 6
#define motor2A 0
#define motor2B 2
#define motor2E 3
#define alarm1 27
#define alarm2 28
#define alarm3 29

using namespace cv;
using namespace std;

int main ( int argc,char **argv ) {
    //system("raspistill -awb off");
    //set Motor
    wiringPiSetup();
    pinMode(motor1A, OUTPUT);
    pinMode(motor1B, OUTPUT);
    pinMode(motor1E, OUTPUT);
    pinMode(motor2A, OUTPUT);
    pinMode(motor2B, OUTPUT);
    pinMode(motor2E, OUTPUT);
    pinMode(alarm1, OUTPUT);
    pinMode(alarm2, OUTPUT);
    pinMode(alarm3, OUTPUT);
    
    //set Value for Detect Fall
    vector<Point2f> CMSeries(5);
    vector<bool> FallSeries(5);
    vector<bool> item(5);
    int i=0;
    while(i<5){
        CMSeries[i].x = 0;
        CMSeries[i].y = 240;
        FallSeries[i] = false;
        item [i] = false;
        i++;
    }
    
    CvScalar alm_color;
    bool Fall;
    int State_stunt = 0,v;
    float percentFall,CMMax = 240;
    float SitHigh;
    Mat src,frame;
    
    int kernel_size = 20;
    Point anchor=Point(10,10);
    Mat kernal = Mat::ones(kernel_size,kernel_size,CV_32F)/(float)(kernel_size*kernel_size);
    
    int kernel_size1 = 4;
    Point anchor1=Point(2,2);
    Mat kernal1 = Mat::ones(kernel_size1,kernel_size1,CV_32F)/(float)(kernel_size1*kernel_size1);
    
    int row = 240;
    int col = 320;
    Mat HSV_img(row,col,CV_8UC3);
    Mat Color1(row,col,CV_8UC1);
    Mat Color2(row,col,CV_8UC1);
    Mat AndColor(row,col,CV_8UC1);
    Mat dst_shirt(row,col,CV_8UC1,Scalar::all(0));
    int largest_area=0,largest_contour_index=999;
    
    //Rect bounding_rect;
    //vector<vector<Point> > contours_shirt;
    // Vector for storing contour
    //vector<Vec4i> hierarchy_shirt;
    vector<Point2f> CM(1);
    vector<Moments> mu(1);
    Mat Shoes_bi(row,col,CV_8UC1);
    Mat dst_shoes(row,col,CV_8UC1,Scalar::all(0));
    int first_area=0,second_area=0;
    int first_area_index=0,second_area_index=0;
    //Rect bounding_rect1,bounding_rect2;
    //vector<vector<Point> > contours_shoes;
    // Vector for storing contour //vector<Vec4i> hierarchy_shoes;
    cv.CreatedWindow("Binary"); cv.CreatedWindow("Frame"); cv.CreatedWindow("alarm");
    
    //set camera params
    raspicam::RaspiCam_Cv Camera;
    Camera.set( CV_CAP_PROP_FORMAT, CV_8UC3 ); Camera.set( CV_CAP_PROP_FRAME_WIDTH, col);
    Camera.set( CV_CAP_PROP_FRAME_HEIGHT, row);
    Camera.set( CV_CAP_PROP_FPS, 10.0);
    //Camera.set( CV_CAP_PROP_BRIGHTNESS, 50 );
    //Camera.set( CV_CAP_PROP_CONTRAST, 100 );
    //Camera.set( CV_CAP_PROP_HUE,0);
    //Camera.set( CV_CAP_PROP_SATURATION,100);
    //Camera.set( CV_CAP_PROP_GAIN, 1000.0 );
    //Camera.set( CV_CAP_PROP_EXPOSURE ,-1);
    //Camera.set( CV_CAP_PROP_WHITE_BALANCE ,5);
    //Camera.set( 18 ,100);
    //Camera.AWB_MODES 'off';
    
    //Open camera
    cout<<"Opening Camera..."<<endl;
    if (!Camera.open()) {cerr<<"Error opening the camera"<<endl;return -1;}
    
    //Start capture
    while(true){
        ////Cature////////////////////////////////////////////////////////////////////////
        Camera.grab();
        Camera.retrieve ( src); //flip(src,src,0);
        //src = frame;
    
        ////Convert to HSV////////////////////////////////////////////////////////////////////////
        cvtColor(src,HSV_img,CV_BGR2HSV);
    
        ////Deatect shirt////////////////////////////////////////////////////////////////////////
        ////Deatect Color1////////////////////////////////////////////////////////////////////////
        inRange(HSV_img,cv::Scalar(140,20,50),cv::Scalar(180,255,240),Color1);//Blue color
        dilate(Color1,Color1,kernal,anchor); erode(Color1,Color1,kernal,anchor);
    
        ////Deatect Color2////////////////////////////////////////////////////////////////////////
        inRange(HSV_img,cv::Scalar(80,40,50),cv::Scalar(120,240,255),Color2);//pink
        dilate(Color2,Color2,kernal,anchor); erode(Color2,Color2,kernal,anchor);
    
        ////Add Color/////////////////////////////////////////////////////////////////////////////

        bitwise_and(Color1,Color2,AndColor) ;
        //imshow( "AndColor", AndColor );
    
        ////conture shirt////////////////////////////////////////////////////////////////////////
        Mat dst_shirt(src.rows,src.cols,CV_8UC1,Scalar::all(0));
        largest_area=0;
        largest_contour_index=999;
        Rect bounding_rect;
        vector<vector<Point> > contours_shirt; // Vector for storing contour
        vector<Vec4i> hierarchy_shirt;
        findContours( AndColor, contours_shirt, hierarchy_shirt,CV_RETR_CCOMP, CV_CHAIN_APPROX_SIMPLE ); // Find the contours in the image
        
        i=0;
        while(i< contours_shirt.size()){
            double a=contourArea( contours_shirt[i],false); // Find the area of contour
            if(a>largest_area ){
                largest_area=a;
                largest_contour_index=i; //Store the index of largest
                bounding_rect=boundingRect(contours_shirt[i]);
            }
            i++;
        } // Find the bounding rectangle for biggest contour
    
        if (largest_area > 20){
            Scalar color( 255,255,255);
            drawContours( dst_shirt, contours_shirt,largest_contour_index, color, CV_FILLED, 8, hierarchy_shirt ); // Draw the largest contour using previously stored index.
            rectangle(src, bounding_rect, Scalar(0,255,0),1, 8,0);
        }
        
        /////Moment Shirt////////////////////////////////////////////////////////////////////////
        //vector<Point2f> CM(1);
        CM[0].x = 0;
        CM[0].y = 240;
        if(largest_contour_index != 999){
            
            //vector<Moments> mu(1);
            mu[0] = moments( contours_shirt[largest_contour_index], false );
            
            /// Get the mass centers:
            CM[0] = Point2f( mu[0].m10/mu[0].m00 , mu[0].m01/mu[0].m00 ); float area = mu[0].m00;
            float wight = mu[0].m10;
            //printf("wight %f",wight);
            
            /// Contorl Robot
            if (CM[0].y >50){
                if (CM[0].x <= 130){
                    printf( "\n\nTurn Right\tcm(%.2f,%.2f)\t",CM[0].x,CM[0].y);
                    digitalWrite(motor1A, HIGH);
                    digitalWrite(motor1B, LOW);
                    digitalWrite(motor1E, HIGH);
                    digitalWrite(motor2A, LOW);
                    digitalWrite(motor2B, HIGH);
                    digitalWrite(motor2E, HIGH);
                }else if (CM[0].x >= 190){
                    printf( "\n\nTurn Left\tcm(%.2f,%.2f)\t",CM[0].x,CM[0].y);
                    digitalWrite(motor1A, LOW);
                    digitalWrite(motor1B, HIGH);
                    digitalWrite(motor1E, HIGH);
                    digitalWrite(motor2A, HIGH);
                    digitalWrite(motor2B, LOW);
                    digitalWrite(motor2E, HIGH);
                }else{
                    if (area > 4000){
                        printf("\n\nBackward\tcm(%.2f,%.2f)\t",CM[0].x,CM[0].y);
                        digitalWrite(motor1A, LOW);
                        digitalWrite(motor1B, HIGH);
                        digitalWrite(motor1E, HIGH);
                        digitalWrite(motor2A, LOW);
                        digitalWrite(motor2B, HIGH);
                        digitalWrite(motor2E, HIGH);
                    }else if (area > 1200){
                        printf( "\n\nStop!!\t\tcm(%.2f,%.2f)\t",CM[0].x,CM[0].y);
                        digitalWrite(motor1E, LOW);
                        digitalWrite(motor2E, LOW);
                    }else if (area < 1200){
                        printf( "\n\nForward\tcm(%.2f,%.2f)\t",CM[0].x,CM[0].y);
                        digitalWrite(motor1A, HIGH);
                        digitalWrite(motor1B, LOW);
                        digitalWrite(motor1E, HIGH);
                        digitalWrite(motor2A, HIGH);
                        digitalWrite(motor2B, LOW);
                        digitalWrite(motor2E, HIGH);
                    }
                }
                circle( src, CM[0], 10,cvScalar(255,255,255) , -1, 8, 0 ); //
            }else{
                printf( "\n\nBackward\tcm(%.2f,%.2f)\t",CM[0].x,CM[0].y);
                digitalWrite(motor1A, LOW);
                digitalWrite(motor1B, HIGH);
                digitalWrite(motor1E, HIGH);
                digitalWrite(motor2A, LOW);
                digitalWrite(motor2B, HIGH);
                digitalWrite(motor2E, HIGH);
                //printf( "\n\nNosee\t\tcm(%.2f,%.2f)\t",CM[0].x,CM[0].y); CM[0].x = 0;
                CM[0].y = 240;
                //digitalWrite(motor1E, LOW);
                //digitalWrite(motor2E, LOW);
            }
        }else{
            printf( "\n\nNosee\t\tcm(%.2f,%.2f)\t",CM[0].x,CM[0].y); CM[0].x = 0;
            CM[0].y = 240;
            digitalWrite(motor1E, LOW);
            digitalWrite(motor2E, LOW);
        }
        
    ////Detect Yellow Shoes////////////////////////////////////////////////////////////////////////
    //Mat Shoes_bi(src.rows,src.cols,CV_8UC1);
    inRange(HSV_img,cv::Scalar(20,200,200),cv::Scalar(40,255,255),Shoes_bi);
    dilate(Shoes_bi,Shoes_bi,kernal1,anchor1);
    erode(Shoes_bi,Shoes_bi,kernal1,anchor1);
    //imshow("Shoes",Shoes_bi);
        
    ////conture Yellow Shoes////////////////////////////////////////////////////////////////////////
    Mat dst_shoes(src.rows,src.cols,CV_8UC1,Scalar::all(0));
        first_area=0,second_area=0;
        first_area_index=0,second_area_index=0;
    Rect bounding_rect1,bounding_rect2;
    vector<vector<Point> > contours_shoes; // Vector for storing contour
    vector<Vec4i> hierarchy_shoes;
    findContours( Shoes_bi, contours_shoes, hierarchy_shoes,CV_RETR_CCOMP, CV_CHAIN_APPROX_SIMPLE ); // Find the contours in the image
    i=0;

    
    while(i<contours_shoes.size()){
        double a=contourArea( contours_shoes[i],false); // Find the area of
        if(a>first_area && a>25){ first_area=a;
            first_area_index=i; //Store the index of largest contour
            bounding_rect1=boundingRect(contours_shoes[i]);
        } // Find the bounding rectangle for biggest contour
        i++;
    }
    drawContours( dst_shoes, contours_shoes,first_area_index, Scalar(255,255,255),
                 CV_FILLED, 8, hierarchy_shoes ); // Draw the largest contour using previously stored index
    rectangle(src, bounding_rect1, Scalar(0,255,255),1, 8,0);
    int leftmost = bounding_rect1.x;
    int rightmost = bounding_rect1.x+bounding_rect1.width;
    int buttommost = bounding_rect1.y + bounding_rect1.height;
    if (contours_shoes.size() >1){
        i=0;
        while(i< contours_shoes.size()){;
            if (i != first_area_index){
                double a=contourArea( contours_shoes[i],false); //
                if(a>second_area){ second_area=a;
                    second_area_index=i; //Store the
                    bounding_rect2=boundingRect(contours_shoes[i]);
                    
                }
            } // Find the bounding rectangle for biggest contour
            i++;
        }
        if (second_area > 25){
        
            drawContours( dst_shoes, contours_shoes,second_area_index, Scalar(255,255,255), CV_FILLED, 8, hierarchy_shoes ); // Draw the largest contour using previously stored index.
            rectangle(src, bounding_rect2, Scalar(0,255,0),1, 8,0);
            if (leftmost>bounding_rect2.x) leftmost = bounding_rect2.x;
            if (rightmost<bounding_rect2.x+bounding_rect2.width) rightmost = bounding_rect2.x+bounding_rect2.width;
            if (buttommost < bounding_rect2.y + bounding_rect2.height)
                buttommost = bounding_rect2.y + bounding_rect2.height;
            
        }
        
    }
    line(src,cvPoint(leftmost,0),cvPoint(leftmost,480),cvScalar(0,255,255),2,8,0);
    line(src,cvPoint(rightmost,0),cvPoint(rightmost,480),cvScalar(0,255,255),2,8,0);
        
    ////Alarm/////////////////////////////////////////////////////////////////////
    CMSeries[4].x = CMSeries[3].x;
    CMSeries[4].y = CMSeries[3].y;
    CMSeries[3].x = CMSeries[2].x;
    CMSeries[3].y = CMSeries[2].y;
    CMSeries[2].x = CMSeries[1].x;
    CMSeries[2].y = CMSeries[1].y;
    CMSeries[1].x = CMSeries[0].x;
    CMSeries[1].y = CMSeries[0].y;
    CMSeries[0].x = CM[0].x;
    CMSeries[0].y = CM[0].y;
        
    Fall = false;
    alm_color = cvScalar(255,255,255);
    if (leftmost == 0 || rightmost == 0 || CMSeries[0].x == 0 || CMSeries[0].y == 240 ){
        item[4] = item[3];
        item[3] = item[2];
        item[2] = item[1];
        item[1] = item[0];
        item[0] = false;
        if(State_stunt > 1){
            State_stunt--;
            Fall = true;
            alm_color = cvScalar(0,0,255);
        }
        if(State_stunt == 1){
            if(CMSeries[0].y > CMSeries[1].y+10){
                State_stunt=1;
                Fall = true;
                alm_color = cvScalar(0,0,255);
            }else State_stunt = 0;
        }
        if(State_stunt == 0){
            if(CMSeries[0].x != 0 && CMSeries[0].y != 240 && CMSeries[1].x != 0 && CMSeries[1].y != 240){//have shirt
                v = CMSeries[0].y - CMSeries[1].y;
                if(v <= 30){
                     Fall = false;
                     alm_color = cvScalar(0,255,0);
                } if(v > 30){
                     Fall = true;
                     alm_color = cvScalar(0,0,255);
                } if(Fall==true) State_stunt=4;
             }else {
                if (item[0] ==false && item[1] ==false && item[2] ==false){
                     Fall = false;
                     alm_color = cvScalar(255,255,255);
                    
                } else if(FallSeries[0] == false && FallSeries[1] == false && FallSeries[2] == false){
                    Fall = false;
                    alm_color = cvScalar(0,255,0);
                } else{
                    Fall = true;
                    alm_color = cvScalar(0,0,255);
                } State_stunt=0;
             }
        }
    }
   if (leftmost != 0 && rightmost != 0 && CMSeries[0].x != 0 && CMSeries[0].y != 240){
       item[4] = item[3];
       item[3] = item[2];
       item[2] = item[1];
       item[1] = item[0];
       item[0] = true;
       if(State_stunt > 1){
           State_stunt--;
           Fall = true;
           alm_color = cvScalar(0,0,255);
           
       } if(State_stunt == 1){
           if(CMSeries[0].y > CMSeries[1].y-10){
               State_stunt=1;
               Fall = true;
               alm_color = cvScalar(0,0,255);
               
           } else {
               State_stunt = 0;
           }
       }
       if(State_stunt == 0){
           ////get speed CM
           if(CMSeries[0].x > leftmost && CMSeries[0].x < rightmost){
               // v = CMSeries[0].y - CMSeries[1].y;
               if(v <= 30){
                   Fall = false;
                   alm_color = cvScalar(0,255,0);
               }
               if(v > 30){
                    Fall = true;
                    alm_color = cvScalar(0,0,255);
               }
               if(Fall==true) State_stunt=10;
               if(Fall == false){
                   percentFall = abs((CMSeries[0].x - (leftmost + (rightmost-leftmost)/2))*200/(rightmost-leftmost));
                   alm_color = cvScalar(0,255,255*percentFall/100);
               }
           }
           if(CMSeries[0].x <= leftmost || CMSeries[0].x >= rightmost){
               //out of BOS CMMax)*80/100 ;
               SitHigh = buttommost - (buttommost - CMMax)*80/100 ;
                                       
               if(CMSeries[0].y < 250){
                     v = CMSeries[0].y - CMSeries[1].y;
                   if(v <= 30){
                         Fall = false;
                         alm_color = cvScalar(0,255,255);
                   }
                   if(v > 30){
                         Fall = true;
                          alm_color = cvScalar(0,0,255);
                   }
                   if(Fall == true) State_stunt = 10;
               }
               if(CMSeries[0].y >= 60){
                   
                   if(std::find(FallSeries.begin(), FallSeries.end(),true)!=FallSeries.end()) t++;
                   float FallRatio = t/5;
                   if (FallRatio > 0.4){
                        Fall = true;
                        alm_color = cvScalar(0,0,255);
                       
                   } else{
                        v = CMSeries[0].y - CMSeries[1].y;
                        if(v <= 30){
                            Fall = false;
                           alm_color = cvScalar(0,255,0);
                            
                        }
                        if(v > 30){
                              Fall = true;
                              alm_color = cvScalar(0,0,255);
                              State_stunt = 4;
                        }
                       
                   }
                   
               }
               
           }
           
       }
       
   }
    FallSeries[4] = FallSeries[3];
    FallSeries[3] = FallSeries[2];
    FallSeries[2] = FallSeries[1];
    FallSeries[1] = FallSeries[0];
    FallSeries[0] = Fall;
   if(Fall == true){
       digitalWrite(alarm1, HIGH);
       digitalWrite(alarm2, HIGH);
       digitalWrite(alarm3, HIGH);
   }
     if(CMSeries[0].y >= 60){
         int t=0;
         if(Fall == false){
             digitalWrite(alarm1, LOW);
             digitalWrite(alarm2, LOW);
             digitalWrite(alarm3, LOW);
        }
        printf("Fall : %s", Fall?"true":"false");
        Mat alm(100,100,CV_8UC3,alm_color);
        Mat dst(src.rows,src.cols,CV_8UC1,Scalar::all(0)); add(dst_shirt, dst_shoes, dst);
        //imshow("Binary", dst);
        //imshow("Frame", src);
        //imshow("alarm", alm);
        if(waitKey(10) >= 0){
            digitalWrite(motor1E, LOW);
            digitalWrite(motor2E, LOW); break;
        }
         
     }
    cout<<"Stop camera..."<<endl; Camera.release();
    return 0;
    }
