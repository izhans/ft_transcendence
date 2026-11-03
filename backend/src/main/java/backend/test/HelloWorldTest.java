package backend.test;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HelloWorldTest {

	@GetMapping("/api")
	public ResponseEntity<String> TestGet()
	{
		return new ResponseEntity<String>("Hola Mundo!" , HttpStatus.OK);
	}
}
