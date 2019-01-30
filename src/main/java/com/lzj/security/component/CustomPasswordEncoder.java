package com.lzj.security.component;

import org.springframework.security.crypto.password.PasswordEncoder;

/**
 * There is no PasswordEncoder mapped for the id "null" 解决方案
 */
public class CustomPasswordEncoder implements PasswordEncoder {
    @Override
    public String encode(CharSequence charSequence) {
        return charSequence.toString();
    }

    @Override
    public boolean matches(CharSequence charSequence, String s) {
        return s.equals(charSequence.toString());
    }
}
