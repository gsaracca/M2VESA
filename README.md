## VESA codes

# Modula-2 Library to support VESA Graphics Modes.

##### `* ------------------------------------------------------------------------`
##### `* VESA MODE NUMBER      TYPE           RESOLUTION        COLORS           ` 
##### `------------------------------------------------------------------------ `
##### `     100H            GRAPHICS         640* 400           256             `
##### `     101H            GRAPHICS         640* 480           256             `
##### `     102H            GRAPHICS         800* 600            16             `
#####       103H            GRAPHICS         800* 600           256             `
#####       104H            GRAPHICS        1024* 768            16             `
#####       105H            GRAPHICS        1024* 768           256             `
#####       106H            GRAPHICS        1280*1024            16             `
#####       107H            GRAPHICS        1280*1024           256             `
#####                                                                           `
#####       108H            TEXT              80*  60            16             `
#####       109H            TEXT             132*  25            16             `
#####       10AH            TEXT             132*  43            16             `
#####       10BH            TEXT             132*  50            16             `
#####       10CH            TEXT             132*  60            16             `
#####                                                                           `
#####       10DH            GRAPHICS         320* 200           32K             `
#####       10EH            GRAPHICS         320* 200           64K             `
#####       10FH            GRAPHICS         320* 200           16M             `
#####       110H            GRAPHICS         640* 480           32K             `
#####       111H            GRAPHICS         640* 480           64K             `
#####       112H            GRAPHICS         640* 480           16M             `
#####       113H            GRAPHICS         800* 600           32K             `
#####       114H            GRAPHICS         800* 600           64K             `
#####       115H            GRAPHICS         800* 600           16M             `
#####       116H            GRAPHICS        1024* 768           32K             `
#####       117H            GRAPHICS        1024* 768           64K             `
#####       118H            GRAPHICS        1024* 768           16M             `
#####       119H            GRAPHICS        1280*1024           32K             `
#####       11AH            GRAPHICS        1280*1024           64K             `
#####       11BH            GRAPHICS        1280*1024           16M             `
#####                                                                           `
#####  ------------------------------------------------------------------------ `
#####    32K : color modes have 1 unused bit and 5 bits for Reg, Green, Blue.   `
#####    64K : color modes have 5 bits for Reg, Blue & 6 bits for Green.        `
#####    16M : color modes have 8 bits for Reg, Green, Blue.                    `
#####  ------------------------------------------------------------------------ `
