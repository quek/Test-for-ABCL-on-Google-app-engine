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

@SuppressWarnings("serial")
public class AbclServlet extends HttpServlet {

	@Override
	public void init() throws ServletException {
		try {
			AbclInit.init();
		} catch (ConditionThrowable e) {
			throw new ServletException(e);
		}
	}

	@Override
	public void service(HttpServletRequest req, HttpServletResponse resp)
			throws IOException {

		LispThread currentThread = LispThread.currentThread();

		SpecialBinding lastSpecialBinding = currentThread.lastSpecialBinding;
		try {
			currentThread.bindSpecial(Symbol.STANDARD_OUTPUT,
					new org.armedbear.lisp.Stream(resp.getOutputStream(),
							Symbol.CHARACTER, Symbol.internKeyword("UTF-8")));

			resp.setContentType("text/html; charset=utf-8");

			Symbol symbol = Lisp.internInPackage("EXECUTE", "SERVLET");
			currentThread.execute(symbol, new JavaObject(req), new JavaObject(
					resp));
		} catch (ConditionThrowable condition) {
			resp.setContentType("text/plain");
			resp.getWriter().println(condition.toString());

		} finally {
			currentThread.lastSpecialBinding = lastSpecialBinding;
		}

	}
}