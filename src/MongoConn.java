import java.io.Console;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mongodb.BasicDBObject;
import com.mongodb.Block;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;
import com.mongodb.DBObject;
import com.mongodb.MongoClient;
import com.mongodb.MongoClientOptions;
import com.mongodb.MongoClientURI;
import com.mongodb.MongoCredential;
import com.mongodb.ServerAddress;
import com.mongodb.WriteResult;
import com.mongodb.client.MongoIterable;

@SuppressWarnings("serial")
public class MongoConn extends HttpServlet {
	
	private int getParam(HttpServletRequest request, String name) {
		
		if(name == "addict")
			return (request.getParameter(name)!=null && !request.getParameter(name).isEmpty())? 1: 0;
		
		int param = (request.getParameter(name)!=null && !request.getParameter(name).isEmpty())?Integer.parseInt(request.getParameter(name)):-1;
		
		if(param > 1000)
			param = (int) (Math.ceil(param/1000) * 1000);
		
		return param;
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) {				

		try {
			
			int num_prov = getParam(request, "num_prov");
			int num_insur = getParam(request, "num_insur");
			int doll_spent = getParam(request, "doll_spent");
			int num_meds = getParam(request, "num_meds");
			int addict = getParam(request, "addict");
			int perc_family = getParam(request, "perc_family");
			
			int prov = getParam(request, "prov");
			int app = getParam(request, "app");
			int insur = getParam(request, "insur");
			int fin = getParam(request, "fin");
			int info = getParam(request, "info");
			int social = getParam(request, "social");
			int react = getParam(request, "react");
			int thera = getParam(request, "thera");
			int medic = getParam(request, "medic");
			int phase = getParam(request, "phase");
			
			/*PrintWriter out = response.getWriter();  
			response.setContentType("text/html");  
			out.println("<script type=\"text/javascript\">");  
			out.println("alert('Successfully saved to database');");  
			out.println("</script>");*/
			
			MongoClient mongoClient = new MongoClient("127.0.0.1", 27017);
			
			@SuppressWarnings("deprecation")
			DB db = mongoClient.getDB("1kj");					
			
			DBCollection table = db.getCollection("demographics");
			
			BasicDBObject document = new BasicDBObject();
			document.put("number providers", num_prov);
			document.put("number insurances", num_insur);
			document.put("dollars spent", doll_spent);
			document.put("number medications", num_meds);
			document.put("addiction", addict);
			document.put("percentage family", perc_family);
			document.put("find provider", prov);
			document.put("make appointment", app);
			document.put("insurance cover", insur);
			document.put("financial cover", fin);
			document.put("inform others", info);
			document.put("social withdrawal", social);
			document.put("people reactions", react);
			document.put("therapeutic care", thera);
			document.put("medication treatment", medic);
			document.put("journey phase", phase);

			
			for (DBObject doc : table.find()) {
	            System.out.println(doc);
	        }
			
			table.save(document);
			
			for (DBObject doc : table.find()) {
	            System.out.println(doc);
	        }
			
			mongoClient.close();
			
			Thread.sleep(1000);
			
			response.sendRedirect("capture.jsp");
			
		} catch (IOException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	    
		
		/*try {
			
			BasicDBObject document = new BasicDBObject();
			document.put("name", "mkyong");
			document.put("age", 30);
			document.put("createdDate", new Date());
			
			MongoClientOptions.Builder builder = new MongoClientOptions.Builder();
	        //build the connection options  
	        builder.maxConnectionIdleTime(60000);//set the max wait time in (ms)
	        builder.socketKeepAlive(true);
	        builder.socketTimeout(60000);
	        builder.connectTimeout(60000);
	        builder.sslEnabled(true);
	        
	        MongoClientOptions opts = builder.build();
			
			char[] password = "thereisabetterway7997".toCharArray();
			
			ServerAddress address = new ServerAddress("aws-us-east-1-portal.6.dblayer.com", 27017);
			
			MongoCredential credential = MongoCredential.createCredential("devUser", "admin", password);
			
			MongoClient mongoClient = new MongoClient(address, Arrays.asList(credential), opts);
	        
	        MongoClient mongoClient = new MongoClient("127.0.0.1", 27017);
			
			String url = "mongodb://devUser:thereisabetterway7997@aws-us-east-1-portal.6.dblayer.com:20109/admin?ssl=true";

			MongoClient mongoClient = new MongoClient(new MongoClientURI(url));
			
			MongoIterable<String> listDatabaseNames = mongoClient.listDatabaseNames();
			
			System.out.println(listDatabaseNames.first());			
			
			@SuppressWarnings("deprecation")
			DB db = mongoClient.getDB("1kj");					
			
			DBCollection table = db.getCollection("demographics");
						
			//table.insert(document);
			
			DBCursor cursor = table.find(document);

			while (cursor.hasNext()) {
				System.out.println(cursor.next());
			}
			
			mongoClient.close();
			
		} catch (Exception e) {
			
			e.printStackTrace();
			
		}*/
		

	}

}
