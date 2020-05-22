
org 100h

start:
	xor		cx,cx
	xor		dx,dx
	xor		ax,ax
	xor		bx,bx

	
	mov		ah,9
	mov		dx,ent1
	int		21h

	mov		ah,9
	mov		dx,first
	int		21h

	mov		ah,1
	int		21h

	mov		ah,0
	push	ax


	
	mov		ah,9
	mov		dx,ent1
	int		21h

	mov		ah,9
	mov		dx,second
	int		21h

	mov		ah,1
	int		21h

	mov		ah,0
	push	ax

type_operation:
	mov		ah,9
	mov		dx,ent1
	int		21h

	mov		dx,operation
	int		21h

	mov		ah,1
	int		21h

	mov		ah,9
	mov		dx,ent1
	int		21h



select_operation:
	cmp		al,48
	je		substr_oper

	cmp		al,49
	je		add_oper
	cmp		al,50
	je		multipl_oper

	cmp		al,51
	je		div_oper

	


	mov		ah,9
	mov		dx,ent1
	int		21h
	mov		dx,input_err
	int		21h
	jmp		start


	
outOfRange:
	mov		ah,9
	mov		dx,res_err
	int		21h
	jmp		start
	
add_oper:
	push	bp
	mov		bp,sp

	xor		ax,ax
	mov 	ax,[bp+4]
	mov		bx,[bp+2]
	add		ax,bx

	pop		bp

	jmp		calc_result

substr_oper:
	push	bp
	mov		bp,sp

	xor		ax,ax
	mov		ax,[bp+4]
	mov		bx,[bp+2]
	sub		ax,bx

	pop		bp

	jmp		calc_result

multipl_oper:
	push	bp
	mov		bp,sp

	mov		ax,0
	mov		ax,[bp+4]
	mov		bx,[bp+2]
	mul		bl

	jmp		calc_result

div_oper:
	push	bp
	mov		bp,sp

	xor		ax,ax
	mov		ax,[bp+4]
	mov		bx,[bp+2]
	div		bl
	mov		ah,0

	pop		bp

	jmp		calc_result


calc_result:
	push	ax
	push	bp
	mov		bp,sp
	
	cmp		ax,255
	ja		outOfRange

	cmp		ax,0
	jb		outOfRange

	mov		ah,9
	mov		dx,result
	int		21h
	mov		ax,[bp+2]
	
	
	mov 	cx,0
	xor 	bx,bx
	xor 	dx,dx
	mov 	bx,ax
	mov 	dl,10
spr:
	xor 	ax,ax
	mov 	ax,bx
	div 	dl; 
	push	ax
	inc		cx;
	mov		bl,al
	cmp		al, 0 
	jg 		spr
	
	
	mov 	di,2
	push	bp
	mov		bp,sp
loopp:
	xor 	ax,ax
	xor 	dx,dx
	mov 	ax,[bp+di]
	mov 	dl,ah			
	add 	dl,48
	mov 	ah,2
	int 	21h
	add 	di,2
	loop 	loopp
	
	pop		bp


endd:
	mov		ax,4c00h
	int		21h
	




input_err			db 'Out of range (0-255)' ,10,13,36
res_err				db 'Result out of range (0-255)' ,10,13,36

first				db 'Type 1st ASCII character from the range (0-255)' ,10,13,36
second				db 'Type 2st ASCII character from the range (0-255)' ,10,13,36
operation 			db 'Select operation: 0) Subtr, 1) Add, 2) Multipl, 3) Div',10,13,36
ent1				db 10,13,36
result 				db 'Result:' , 10,13,36

