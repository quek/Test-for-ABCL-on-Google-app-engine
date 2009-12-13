package j;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.armedbear.lisp.Interpreter;
import org.armedbear.lisp.JavaObject;
import org.armedbear.lisp.Lisp;
import org.armedbear.lisp.LispThread;
import org.armedbear.lisp.Load;
import org.armedbear.lisp.SpecialBindingsMark;
import org.armedbear.lisp.Symbol;

@SuppressWarnings("serial")
public class AbclServlet extends HttpServlet {

	static {
	}

	@Override
	public void init() throws ServletException {
		super.init();
		Interpreter.initializeLisp();
		Load.load("WEB-INF/lisp/load-gae.abcl");
	}

	@Override
	public void service(HttpServletRequest req, HttpServletResponse resp)
			throws IOException {

		LispThread currentThread = LispThread.currentThread();

		SpecialBindingsMark mark = currentThread.markSpecialBindings();
		try {
			currentThread.bindSpecial(Symbol.STANDARD_OUTPUT,
					new org.armedbear.lisp.Stream(resp.getOutputStream(),
							Symbol.CHARACTER, Lisp.PACKAGE_KEYWORD
									.intern("UTF-8")));

			resp.setContentType("text/html; charset=utf-8");

			Symbol symbol = Lisp.internInPackage("RUN-SERVLET", "GAE");
			currentThread.execute(symbol, new JavaObject(req), new JavaObject(
					resp));
		} finally {
			currentThread.resetSpecialBindings(mark);
		}
	}
}