package com.gsparvej.angularWithSpringBoot.restcontroller;

import com.gsparvej.angularWithSpringBoot.entity.ChatMessage;
import com.gsparvej.angularWithSpringBoot.service.ChatMessageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/messages")
public class ChatMessageRestController {

    @Autowired
    private ChatMessageService chatMessageService;

    @GetMapping("")
    public List<ChatMessage> getMessages() {
        return chatMessageService.getAllMessages();
    }

    @PostMapping("")
    public ChatMessage sendMessage(@RequestBody ChatMessage message) {
        return chatMessageService.sendMessage(message);
    }
}
