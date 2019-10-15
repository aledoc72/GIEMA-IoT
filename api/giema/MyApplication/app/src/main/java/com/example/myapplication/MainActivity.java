package com.example.myapplication;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.os.StrictMode;

import android.util.Log;
import android.widget.TextView;
import android.widget.Toast;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;

public class MainActivity extends AppCompatActivity {

    TextView usu;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        usu = (TextView) findViewById(R.id.usuario);
        getUsuario();
    }

    public void getUsuario (){

        String sql = "http://192.168.0.24/rest/webService/controller/usuario.php";

        StrictMode.ThreadPolicy policy = new StrictMode.ThreadPolicy.Builder().permitAll().build();
        StrictMode.setThreadPolicy(policy);

        URL url = null;
        HttpURLConnection conn;

        try {
            url = new URL(sql);

            conn = (HttpURLConnection) url.openConnection();


            conn.setRequestMethod("GET");

            conn.connect();

            BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));

            String inputLine;

            StringBuffer response = new StringBuffer();

            String json = "";

            while((inputLine = in.readLine())!=null){
                response.append(inputLine);

            };

            json =  response.toString();

            JSONArray jsonArr = null;

            jsonArr = new JSONArray(json);

            String mensaje = "";

            for(int i = 0 ; i<jsonArr.length();i++){

                JSONObject jsonObject = jsonArr.getJSONObject(i);

                Log.d("nombres",jsonObject.optString("nombres"));
                mensaje += "Usuarios "+i+" "+jsonObject.optString("nombres")+"\n";

            }

            usu.setText(mensaje);




        } catch (MalformedURLException e) {
            e.printStackTrace();
        }catch (IOException e){
            e.printStackTrace();
        } catch (JSONException e) {
            e.printStackTrace();
        }

    }

}
