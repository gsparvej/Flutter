package com.gsparvej.angularWithSpringBoot.security;

import com.gsparvej.angularWithSpringBoot.jwt.JwtAuthenticationFilter;
import com.gsparvej.angularWithSpringBoot.jwt.JwtService;
import com.gsparvej.angularWithSpringBoot.service.UserService;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.Customizer;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.CorsConfigurationSource;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;

import java.util.List;

@Configuration
@EnableWebSecurity
public class SecurityConfig {



    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http,
                                           JwtAuthenticationFilter jwtAuthenticationFilter,
                                           UserService userService) throws Exception {

        return http
                .csrf(AbstractHttpConfigurer::disable)
                .cors(Customizer.withDefaults())
                .authorizeHttpRequests(req -> req
                        .requestMatchers("/api/auth/login",
                                "/api/auth/logout",
                                "/api/auth/active/**",
                                "/api/auth/all",
                                "/api/super_admin/reg",
                                "/api/super_admin/all",
                                "/api/admin/reg",
                                "/api/admin/all" ,
                                "/api/hr_admin/reg",
                                "/api/merchan_manager/reg",
                                "/api/pro_manager/reg",
                                "/api/purchase_manager/reg",
                                "/images/**",
                                "/api/order/**",
                                "/api/department/**",

                                "/api/super_admin/reg",
                                "/api/super_admin/profile",
                                "/api/pro_manager/reg",
                                "/api/purchase_manager/reg",

                                "/api/admin/reg",
                                "/api/admin/profile",
                                "/api/department",
                                "/api/designation/by-department/**",
                                "/api/designation",

                                "/api/hr_admin/reg",

                                "/api/merchan_manager/**",
                                "/api/merchan_manager/profile",
                                "/api/bom/style/**" ,
                                "/api/buyer",
                                "/api/buyer/**",
                                "/api/raw_materials",

                                "/api/pro_manager/**",
                                "/api/pro_manager/profile",
                                "/api/dayWisePro",
                                "/api/dayWisePro/all",
                                "/api/line",
                                "/api/machine" ,
                                "/api/production_order",
                                "/api/production_order/production_OrderId/**",
                                "/api/proSummaryorder",
                                "/api/proSummaryorder/production-summary",
                                "/api/proSummaryorder/production-summaryAll",
                                "/api/cutBundle",
                                "/api/cutting_plan",
                                "/api/cutting_plan/production_OrderId/**",

                                "/api/purchase_manager/**",
                                "/api/purchase_manager/profile",
                                "/api/vendor",
                                "/api/vendor/**" ,
                                "/api/item",
                                "/api/stock_in",
                                "/api/stock_out",
                                "/api/inventory",
                                "/api/inventory/add",
                                "/api/inventory/remove" ,
                                "/api/requisition" ,
                                "/api/requisition/**",
                                "/api/requisition/id/**",
                                "/api/po" ,
                                "/api/po/id/**",

                                "/api/order/**",
                                "/api/bomstyle",
                                "/api/bomstyle/**",
                                "/api/uom",
                                "/api/uom/**",

                                "/api/messages"

                                ).permitAll()
                        .anyRequest().authenticated()
                )
                .userDetailsService(userService)
                .sessionManagement(session ->
                        session.sessionCreationPolicy(SessionCreationPolicy.STATELESS)
                )
                .addFilterBefore(jwtAuthenticationFilter, UsernamePasswordAuthenticationFilter.class)
                .build();
    }






    @Bean
    public JwtAuthenticationFilter jwtAuthenticationFilter(JwtService jwtService, UserService userService) {
        return new JwtAuthenticationFilter(jwtService, userService);
    }

    @Bean
    public AuthenticationManager authenticationManager(AuthenticationConfiguration configuration) throws Exception {
        return configuration.getAuthenticationManager();
    }

    @Bean
    public PasswordEncoder encoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    public CorsConfigurationSource corsConfigurationSource() {
        CorsConfiguration configuration = new CorsConfiguration();
        configuration.setAllowedOrigins(List.of("http://localhost:4200", "http://localhost:41500"));
        configuration.setAllowedMethods(List.of("GET", "POST", "DELETE", "PUT", "OPTIONS"));
        configuration.setAllowedHeaders(List.of("Authorization", "Cache_Control", "Content-type"));
        configuration.setAllowCredentials(true);

        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
        source.registerCorsConfiguration("/**", configuration);
        return source;
    }



//    @Bean
//    public CorsConfigurationSource corsConfigurationSource() {
//        CorsConfiguration configuration = new CorsConfiguration();
////        configuration.setAllowedOrigins(List.of("http://localhost:4200", "http://192.168.88.250:4200"));
//        configuration.setAllowedOrigins(List.of("*"));
//        configuration.setAllowedMethods(List.of("GET", "POST", "DELETE", "PUT", "OPTIONS"));
//        configuration.setAllowedHeaders(List.of("Authorization", "Cache-Control", "Content-Type"));
//        configuration.setAllowCredentials(true);
//
//        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
//        source.registerCorsConfiguration("/**", configuration);
//        return source;
//    }
}
