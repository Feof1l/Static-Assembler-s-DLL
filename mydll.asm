.386
.model flat, c
option casemap: none


.code

;---------------------------------------------------------------------
;Инициализирующая процедура библиотеки. Имя процедуры может быть любым
;---------------------------------------------------------------------
DllMain proc hInstDLL:DWORD, reason:DWORD, reserved:DWORD
      mov eax, -1
      ret
DllMain endp

LastSymb proc src:DWORD, dst:DWORD, symbol:DWORD
    push ebp
    push esp
    push esi
    push edi

    mov esi, [src]
    mov edi, [dst]
    mov edx, [symbol]
    mov dl, [edx]

    xor ebx, ebx
    xor ecx, ecx

    mov ecx, esi
	mov byte ptr [edi], 0
	
	CheckExit:
		mov bl,[ecx]
		cmp bl, 0
		je Exit

	SkipSpaces:
		mov bl,[ecx]
		cmp bl, 32
		jne ToEndWord

		inc ecx
		jmp SkipSpaces
	
	
	ToEndWord:
		mov bl,[ecx]

		cmp bl, 0
		je CheckSymb

		cmp bl, 32
		je CheckSymb

		inc ecx
		jmp ToEndWord

	CheckSymb:
		mov bl, [ecx - 1]
		cmp bl, dl
		jne CheckExit

	ToBeginWord:
		dec ecx
		mov bl, [ecx]
		cmp bl, 32
		je ToFirstSymb

		cmp ecx, esi
		je CopyWord
		
		jmp ToBeginWord

	ToFirstSymb:
		inc ecx
		
	
	CopyWord:
		mov bl, [ecx]
		mov byte ptr [edi], bl
		inc edi
		inc ecx

		cmp bl, 32
		je CopyEnd
		
		cmp bl, 0
		je CopyEnd

		jmp CopyWord

	CopyEnd:
		mov byte ptr [edi], 0
		dec ecx
		jmp CheckExit

	Exit:
		pop edi ;возврат значений
		pop esi
		pop esp
		pop ebp

    ret
	
LastSymb endp

End DllMain
