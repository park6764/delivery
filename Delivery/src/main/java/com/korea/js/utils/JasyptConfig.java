package com.korea.js.utils;

import org.springframework.context.annotation.Configuration;

import com.ulisesbocchio.jasyptspringboot.annotation.EnableEncryptableProperties;


@Configuration
@EnableEncryptableProperties // ENC()로 암호화된 값을 알아서 복호화 한다.
public class JasyptConfig { 
}
