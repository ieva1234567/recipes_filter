import React, {useState, useEffect} from 'react';
import {Autocomplete, TextField} from '@mui/material';

export default function IngredientsInput({label, selectedIngredients, setSelectedIngredients, ingredientOptions}) {
    return <>
        <div className="muiAutocompleteInput" >
            <Autocomplete
                multiple
                freeSolo
                options={ingredientOptions}
                getOptionLabel={(option) => option}
                defaultValue={[]}
                onChange={(event, currValueArray, action, {option: selectedValue}) => 
                    setSelectedIngredients(currValueArray, action, selectedValue)}
                value={selectedIngredients}
                renderInput={(params) => (
                <TextField
                    {...params}
                    sx = {{
                        backgroundColor: "white",
                        height: "60px",
                        "& .MuiFormLabel-root": {
                            color: "grey !important",
                            fontSize: "inherit",
                            left: "5px",
                            fontFamily: "poppins,sans-serif"
                        },
                        "& .MuiInputBase-root": {
                            paddingLeft: "7px",
                            fontFamily: "poppins,sans-serif"
                        }
                    }}
                    variant="standard"
                    label={label}
                    InputProps={{...params.InputProps, disableUnderline: true}}
                />
                )}
            />
        </div>
    </>
}