package com.gsparvej.angularWithSpringBoot.restcontroller;

import com.gsparvej.angularWithSpringBoot.dto.DesignationResponseDTO;
import com.gsparvej.angularWithSpringBoot.dto.FullOrderViewResponseDTO;
import com.gsparvej.angularWithSpringBoot.dto.OrderResponseDTO;
import com.gsparvej.angularWithSpringBoot.entity.*;
import com.gsparvej.angularWithSpringBoot.repository.IBomStyleRepo;
import com.gsparvej.angularWithSpringBoot.repository.IBuyerRepo;
import com.gsparvej.angularWithSpringBoot.repository.IOrderRepo;
import com.gsparvej.angularWithSpringBoot.service.BomStyleService;
import com.gsparvej.angularWithSpringBoot.service.BuyerService;
import com.gsparvej.angularWithSpringBoot.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/order")
@CrossOrigin("*")
public class OrderRestController {

    @Autowired
    private OrderService orderService;
    @Autowired
    private BomStyleService bomStyleService;
    @Autowired
    private BuyerService buyerService;

    @Autowired
    private IOrderRepo orderRepo;
    @Autowired
    private IBomStyleRepo bomStyleRepo;
    @Autowired
    private IBuyerRepo buyerRepo;



    @GetMapping("")
    public List<OrderResponseDTO> getAllOrders() {
        return orderService.getAllOrderResponseDTOS();
    }
    @GetMapping("/{id}")
    public List<FullOrderViewResponseDTO> getOrderByIdFromDTOs(@PathVariable int id) {
        return orderService.getViewOrderViewResponseDTOS(id);
    }

    @GetMapping("/all")
    public List<Order> getAllOrder() {
        return orderService.getAllOrders();
    }


    @PostMapping("")
    public ResponseEntity<Order> createOrder(@RequestBody Order order) {

        if (order.getBomStyle() == null || order.getBomStyle().getId() == 0) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "BomStyle ID is required");
        }
        if (order.getBuyer() == null || order.getBuyer().getId() == 0) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Buyer ID is required");
        }

        BomStyle bomStyle = bomStyleRepo.findById(order.getBomStyle().getId())
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "BomStyle not found"));

        Buyer buyer = buyerRepo.findById(order.getBuyer().getId())
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Buyer not found"));

        Order saved = orderService.saveOrUpdate(order, bomStyle, buyer);

        return new ResponseEntity<>(saved, HttpStatus.CREATED);
    }
//@GetMapping("/{id}")
//public ResponseEntity<Order> getOrderById(@PathVariable int id) {
//        Optional<Order> order = orderService.getAllOrders()
//                .stream()
//                .filter(or -> or.getId() == id)
//                .findFirst();
//        return order.map(ResponseEntity::ok)
//                .orElseGet(()-> ResponseEntity.notFound().build());
//}



    // Example: /api/orders/by-style/ST-1001
    @GetMapping("/by-style/{styleCode}")
    public List<FullOrderViewResponseDTO> getOrdersByStyle(@PathVariable String styleCode) {
        return orderService.getOrdersByStyleCode(styleCode);
    }



}
