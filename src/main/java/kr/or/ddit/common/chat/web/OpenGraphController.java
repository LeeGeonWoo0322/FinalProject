
package kr.or.ddit.common.chat.web;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import kr.or.ddit.common.chat.service.IOpenGraphService;

@RestController
public class OpenGraphController {

    @Inject
    private IOpenGraphService openGraphService;

    @GetMapping("/fetch-og-data")
    public Map<String, String> fetchOpenGraphData(@RequestParam String url) {
        return openGraphService.fetchOpenGraphData(url);
    }
}
