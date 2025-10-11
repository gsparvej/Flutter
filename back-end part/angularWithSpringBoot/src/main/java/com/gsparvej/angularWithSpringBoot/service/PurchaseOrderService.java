package com.gsparvej.angularWithSpringBoot.service;

import com.gsparvej.angularWithSpringBoot.dto.*;
import com.gsparvej.angularWithSpringBoot.entity.*;
import com.gsparvej.angularWithSpringBoot.repository.IItemRepo;
import com.gsparvej.angularWithSpringBoot.repository.IPurchaseOrderRepo;
import com.gsparvej.angularWithSpringBoot.repository.IVendorRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PurchaseOrderService {

    @Autowired
    private IPurchaseOrderRepo purchaseOrderRepo;


    @Autowired
    private IVendorRepo vendorRepo;
    @Autowired
    private IItemRepo itemRepo;

    public List<PurchaseOrder> getAllPurchaseOrders() {
        return purchaseOrderRepo.findAll();
    }

    public PurchaseOrder saveOrUpdate(PurchaseOrder purchaseOrder) {
        Vendor vendor = vendorRepo.findById(purchaseOrder.getVendor().getId())
                .orElseThrow(() -> new RuntimeException("Vendor not found with id: " + purchaseOrder.getVendor().getId()));


        Item item = itemRepo.findById(purchaseOrder.getItem().getId())
                .orElseThrow(()-> new RuntimeException("Item not found with id: " + purchaseOrder.getItem().getId()));
        purchaseOrder.setVendor(vendor);
        purchaseOrder.setItem(item);


        return purchaseOrderRepo.save(purchaseOrder);
    }


    public void deleteById(Integer id) {
        purchaseOrderRepo.deleteById(id);
    }
    public PurchaseOrder getById(Integer id) {
        return purchaseOrderRepo.findById(id)
                .orElseThrow(() -> new RuntimeException("Purchase Order not found"));
    }



    public List<PurchaseOrderResponseDTO> getAllPurchaseOrderResponseDTOS() {
        return purchaseOrderRepo.findAll().stream().map(order -> {
            PurchaseOrderResponseDTO dto = new PurchaseOrderResponseDTO();
            dto.setId(order.getId());
            dto.setPoDate(order.getPoDate());
            dto.setDeliveryDate(order.getDeliveryDate());
            dto.setPoNumber(order.getPoNumber());
            dto.setQuantity(order.getQuantity());
            dto.setRate(order.getRate());
            dto.setSubTotal(order.getSubTotal());
            dto.setTax(order.getTax());
            dto.setTotalAmount(order.getTotalAmount());
            dto.setTermsAndCondition(order.getTermsAndCondition());






            Vendor vendor = order.getVendor();
            if (vendor != null) {
                VendorResponseDTO vendorResponseDTO = new VendorResponseDTO();
                vendorResponseDTO.setCompanyName(vendor.getCompanyName());
                vendorResponseDTO.setAddress(vendor.getAddress());
                vendorResponseDTO.setPhone(vendor.getPhone());
                vendorResponseDTO.setContactPerson(vendor.getContactPerson());
                dto.setVendor(vendorResponseDTO);


            }

            Item item = order.getItem();
            if (item != null) {
                ItemResponseDTO itemResponseDTO = new ItemResponseDTO();

                itemResponseDTO.setCategoryName(item.getCategoryName());

                dto.setItem(itemResponseDTO);
            }


            return dto;
        }).toList();
    }


    public List<PurchaseOrderResponseDTO> getPurchaseOrderFullViewResponseDTOS(int id) {
        return purchaseOrderRepo.findById(id).stream().map(order -> {
            PurchaseOrderResponseDTO dto = new PurchaseOrderResponseDTO();
            dto.setId(order.getId());
            dto.setPoDate(order.getPoDate());
            dto.setDeliveryDate(order.getDeliveryDate());
            dto.setPoNumber(order.getPoNumber());
            dto.setQuantity(order.getQuantity());
            dto.setRate(order.getRate());
            dto.setSubTotal(order.getSubTotal());
            dto.setTax(order.getTax());
            dto.setTotalAmount(order.getTotalAmount());
            dto.setTermsAndCondition(order.getTermsAndCondition());




            Vendor vendor = order.getVendor();
            if (vendor != null) {
                VendorResponseDTO vendorResponseDTO = new VendorResponseDTO();
                vendorResponseDTO.setCompanyName(vendor.getCompanyName());
                vendorResponseDTO.setAddress(vendor.getAddress());
                vendorResponseDTO.setPhone(vendor.getPhone());
                vendorResponseDTO.setContactPerson(vendor.getContactPerson());
                dto.setVendor(vendorResponseDTO);


            }

            Item item = order.getItem();
            if (item != null) {
                ItemResponseDTO itemResponseDTO = new ItemResponseDTO();

                itemResponseDTO.setCategoryName(item.getCategoryName());

                dto.setItem(itemResponseDTO);
            }

            return dto;
        }).toList();
    }
}
