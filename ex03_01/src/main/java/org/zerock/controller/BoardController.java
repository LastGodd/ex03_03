package org.zerock.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.service.BoardService;

import lombok.extern.log4j.Log4j;

@Log4j
@RequestMapping("/board/*")
@Controller
public class BoardController {

	@Autowired
	private BoardService service;

//	@GetMapping("/list")
//	public void getList(Model model) {
//		model.addAttribute("list", service.getList());
//	}
	
	@GetMapping("/list")
	public void getList(Model model, Criteria cri) {
		model.addAttribute("list", service.getList(cri));
	}

	@GetMapping({"/get", "/modify"})
	public void get(@RequestParam("bno") Long bno, Model model) {
		model.addAttribute("board", service.get(bno));
	}

	@GetMapping("/register")
	public void register() {
		
	}
	
	@PostMapping("/register")
	public String register(BoardVO vo, RedirectAttributes rttr) {
		if(service.register(vo)) {
			rttr.addFlashAttribute("result", vo.getBno());
		}
		return "redirect:/board/list";
	}

	@PostMapping("/remove")
	public String remove(@RequestParam("bno") Long bno, RedirectAttributes rttr) {
		if(service.remove(bno)) {
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:/board/list";
	}

	@PostMapping("/modify")
	public String modify(BoardVO vo, RedirectAttributes rttr) {
		if(service.modify(vo)) {
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:/board/list";
	}
}
