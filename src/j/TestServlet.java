package j;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.armedbear.lisp.ConditionThrowable;
import org.armedbear.lisp.JavaObject;
import org.armedbear.lisp.Lisp;
import org.armedbear.lisp.LispThread;
import org.armedbear.lisp.SpecialBinding;
import org.armedbear.lisp.Symbol;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.Key;

@SuppressWarnings("serial")
public class TestServlet extends HttpServlet {


	@Override
	public void service(HttpServletRequest req, HttpServletResponse resp)
			throws IOException {
			resp.setContentType("text/plain; charset=utf-8");
			DatastoreService service = DatastoreServiceFactory.getDatastoreService();
			Entity entity = new Entity("Bano");
			entity.setProperty("name", "baha1");
			Key key = service.put(entity);
			resp.getWriter().println(key);
	}
}