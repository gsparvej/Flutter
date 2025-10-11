package com.gsparvej.angularWithSpringBoot.service;

import com.gsparvej.angularWithSpringBoot.entity.ChatMessage;
import com.gsparvej.angularWithSpringBoot.repository.IChatMessageRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class ChatMessageService {
    @Autowired
    private IChatMessageRepo chatMessageRepo;

    public List<ChatMessage> getAllMessages() {
        return chatMessageRepo.findAll();
    }

    public ChatMessage sendMessage(ChatMessage message) {
        message.setTimestamp(LocalDateTime.now());
        return chatMessageRepo.save(message);
    }
}
