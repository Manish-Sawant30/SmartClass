package com.example.institute.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
@EnableWebSecurity
public class SecurityConfig {
    
    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
            .csrf(csrf -> csrf.disable())
            .authorizeHttpRequests(auth -> auth
                .requestMatchers(
                    "/content/**",
                    "/student-course/**",
                    "/upload-notes/**",
                    "/courses/**",
                    "/css/**",
                    "/js/**",
                    "/images/**",
                    "/api/**",
                    // ADD CERTIFICATE ENDPOINTS HERE
                    "/certificate/**",
                    "/certificateF1",
                    "/certificate-success",
                    "/certificate-error",
                    "/certificate-test"
                ).permitAll()
                .anyRequest().permitAll()
            )
            .headers(headers -> headers
                .frameOptions(frameOptions -> frameOptions.disable())
            );
        
        return http.build();
    }
}